from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
import os
from datetime import datetime

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///users.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password_hash = db.Column(db.String(128))
    user_type = db.Column(db.String(20), nullable=False)  # 'company' or 'candidate'
    company = db.relationship('Company', backref='user', uselist=False)
    candidate_profile = db.relationship('CandidateProfile', backref='user', uselist=False)

class Company(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    company_name = db.Column(db.String(100), nullable=False)
    industry = db.Column(db.String(50))
    location = db.Column(db.String(100))
    description = db.Column(db.Text)
    website = db.Column(db.String(200))
    jobs = db.relationship('Job', backref='company', lazy=True)

class Job(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    company_id = db.Column(db.Integer, db.ForeignKey('company.id'), nullable=False)
    title = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text, nullable=False)
    requirements = db.Column(db.Text)
    location = db.Column(db.String(100))
    salary_range = db.Column(db.String(50))
    job_type = db.Column(db.String(50))  # Full-time, Part-time, Contract, etc.
    posted_date = db.Column(db.DateTime, default=datetime.utcnow)
    is_active = db.Column(db.Boolean, default=True)

class CandidateProfile(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    full_name = db.Column(db.String(100), nullable=False)
    title = db.Column(db.String(100))  # Current job title
    experience_years = db.Column(db.Integer)
    skills = db.Column(db.Text)
    education = db.Column(db.Text)
    location = db.Column(db.String(100))
    bio = db.Column(db.Text)
    resume_url = db.Column(db.String(200))
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

@app.route('/api/register', methods=['POST'])
def dang_ky():
    try:
        data = request.get_json()
        username = data.get('username')
        email = data.get('email')
        password = data.get('password')
        user_type = data.get('user_type', 'candidate')  # Default to candidate if not specified

        if User.query.filter_by(username=username).first():
            return jsonify({'message': 'Tên tài khoản đã tồn tại'}), 400

        if User.query.filter_by(email=email).first():
            return jsonify({'message': 'Email đã được sử dụng'}), 400

        new_user = User(
            username=username,
            email=email,
            password_hash=generate_password_hash(password),
            user_type=user_type
        )

        db.session.add(new_user)
        db.session.commit()

        return jsonify({'message': 'Đăng ký thành công'}), 201

    except Exception as e:
        return jsonify({'message': 'Đã xảy ra lỗi', 'error': str(e)}), 500

@app.route('/api/company/profile', methods=['POST'])
def create_company_profile():
    try:
        data = request.get_json()
        user_id = data.get('user_id')
        
        if not User.query.get(user_id):
            return jsonify({'message': 'User not found'}), 404
            
        if User.query.get(user_id).user_type != 'company':
            return jsonify({'message': 'User is not a company account'}), 400

        new_company = Company(
            user_id=user_id,
            company_name=data.get('company_name'),
            industry=data.get('industry'),
            location=data.get('location'),
            description=data.get('description'),
            website=data.get('website')
        )

        db.session.add(new_company)
        db.session.commit()

        return jsonify({'message': 'Company profile created successfully'}), 201

    except Exception as e:
        return jsonify({'message': 'An error occurred', 'error': str(e)}), 500

@app.route('/api/jobs', methods=['POST'])
def post_job():
    try:
        data = request.get_json()
        company_id = data.get('company_id')
        
        if not Company.query.get(company_id):
            return jsonify({'message': 'Company not found'}), 404

        new_job = Job(
            company_id=company_id,
            title=data.get('title'),
            description=data.get('description'),
            requirements=data.get('requirements'),
            location=data.get('location'),
            salary_range=data.get('salary_range'),
            job_type=data.get('job_type')
        )

        db.session.add(new_job)
        db.session.commit()

        return jsonify({'message': 'Job posted successfully', 'job_id': new_job.id}), 201

    except Exception as e:
        return jsonify({'message': 'An error occurred', 'error': str(e)}), 500

@app.route('/api/candidates', methods=['GET'])
def get_candidates():
    try:
        # Get filter parameters
        location = request.args.get('location')
        skills = request.args.get('skills')
        experience = request.args.get('experience')
        
        # Start with base query
        query = CandidateProfile.query
        
        # Apply filters if provided
        if location:
            query = query.filter(CandidateProfile.location.ilike(f'%{location}%'))
        if skills:
            query = query.filter(CandidateProfile.skills.ilike(f'%{skills}%'))
        if experience:
            query = query.filter(CandidateProfile.experience_years >= int(experience))
            
        candidates = query.all()
        
        result = []
        for candidate in candidates:
            result.append({
                'id': candidate.id,
                'full_name': candidate.full_name,
                'title': candidate.title,
                'experience_years': candidate.experience_years,
                'skills': candidate.skills,
                'location': candidate.location,
                'bio': candidate.bio
            })
            
        return jsonify(result), 200

    except Exception as e:
        return jsonify({'message': 'An error occurred', 'error': str(e)}), 500

@app.route('/api/candidates/<int:candidate_id>', methods=['GET'])
def get_candidate_profile(candidate_id):
    try:
        candidate = CandidateProfile.query.get(candidate_id)
        if not candidate:
            return jsonify({'message': 'Candidate not found'}), 404
            
        return jsonify({
            'id': candidate.id,
            'full_name': candidate.full_name,
            'title': candidate.title,
            'experience_years': candidate.experience_years,
            'skills': candidate.skills,
            'education': candidate.education,
            'location': candidate.location,
            'bio': candidate.bio,
            'resume_url': candidate.resume_url
        }), 200

    except Exception as e:
        return jsonify({'message': 'An error occurred', 'error': str(e)}), 500

@app.route('/api/contact-candidate', methods=['POST'])
def contact_candidate():
    try:
        data = request.get_json()
        candidate_id = data.get('candidate_id')
        company_id = data.get('company_id')
        message = data.get('message')
        
        if not CandidateProfile.query.get(candidate_id):
            return jsonify({'message': 'Candidate not found'}), 404
            
        if not Company.query.get(company_id):
            return jsonify({'message': 'Company not found'}), 404
            
        # Here you would typically implement the actual contact logic
        # For example, sending an email or storing the message in a database
        # For now, we'll just return a success message
        
        return jsonify({
            'message': 'Contact request sent successfully',
            'candidate_id': candidate_id,
            'company_id': company_id
        }), 200

    except Exception as e:
        return jsonify({'message': 'An error occurred', 'error': str(e)}), 500

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)

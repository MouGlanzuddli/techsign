<form action="UpdateCandidateProfile" method="post" enctype="multipart/form-data">
    <div class="row">
        <div class="col-xl-6 col-lg-6 col-md-12">
            <div class="form-group">
                <label>Your Name</label>
                <input type="text" class="form-control" name="candidateName" value="${fullName}" required>
            </div>
        </div>
        <div class="col-xl-6 col-lg-6 col-md-12">
            <div class="form-group">
                <label>Job Title</label>
                <input type="text" class="form-control" name="jobTitle" value="${jobTitle}">
            </div>
        </div>
        <div class="col-xl-6 col-lg-6 col-md-12">
            <div class="form-group">
                <label>Email</label>
                <input type="email" class="form-control" name="email" value="${email}" required>
            </div>
        </div>
        <div class="col-xl-6 col-lg-6 col-md-12">
            <div class="form-group">
                <label>Phone Number</label>
                <input type="text" class="form-control" name="phone" value="${phoneInput != null ? phoneInput : phone}">
            </div>
        </div>
        <div class="col-xl-6 col-lg-6 col-md-12">
            <div class="form-group">
                <label>Experience</label>
                <div class="select-ops">
                    <select name="experienceYears">
                        <option value="0" ${experienceYears == 0 ? 'selected' : ''}>Fresher</option>
                        <option value="1" ${experienceYears == 1 ? 'selected' : ''}>1+ Year</option>
                        <option value="5" ${experienceYears == 5 ? 'selected' : ''}>5+ Years</option>
                        <option value="15" ${experienceYears == 15 ? 'selected' : ''}>10+ Years</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-xl-6 col-lg-6 col-md-12">
            <div class="form-group">
                <label>Education Level</label>
                <input type="text" class="form-control" name="educationLevel" value="${educationLevel}">
            </div>
        </div>
        <div class="col-xl-12 col-lg-12 col-md-12">
            <div class="form-group">
                <label>Address</label>
                <input type="text" class="form-control" name="address" value="${address}" required>
            </div>
        </div>
        <div class="col-xl-12 col-lg-12 col-md-12">
            <div class="form-group">
                <label>Profile Visibility</label>
                <input type="checkbox" name="isSearchable" ${isSearchable ? 'checked' : ''}> Allow employers to find my profile
            </div>
        </div>
        <div class="col-xl-12 col-lg-12 col-md-12">
            <button type="submit" class="btn btn-primary">Update Profile</button>
        </div>
    </div>
</form> 
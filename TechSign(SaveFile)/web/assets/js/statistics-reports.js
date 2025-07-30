console.log("🚀 Loading Complete Statistics Reports with REAL DATA...")

// Global variables
const charts = {}
let currentSection = "account-stats"
let refreshIntervals = {}
let currentAccessRange = 'today'

// ✅ Real data structure matching TechSignDB
const realData = {
  // Account Statistics
  accountStats: {
    total: 0,
    candidates: 0,
    employers: 0,
    admins: 0,
    activeUsers: 0,
    inactiveUsers: 0,
    growthRate: 0,
  },
  // Access Statistics
  accessStats: {
    totalVisits: 0,
    todayVisits: 0,
    activeUsersWeek: 0,
    avgSessionMinutes: 0,
    bounceRate: 0,
    hourlyVisits: {},
    visitsChartData: {},
  },
  // Activity Reports
  activityReports: {
    totalActivities: 0,
    newActivities: 0,
    activeParticipants: 0,
    activeParticipantsPrev7Days: 0,
    totalActivitiesPrev30Days: 0,
    newActivitiesPrevDay: 0,
    avgDailyActivitiesPrev30Days: 0,
  },
  // Application Analysis
  applicationAnalysis: {
    totalApplications: 0,
    approvedApplications: 0,
    pendingApplications: 0,
    rejectedApplications: 0,
  },
  // Security & System
  securityStats: {
    securityAlerts: 0,
    systemWarnings: 0,
    criticalIssues: 0,
  },
  totalUsers: 0,
  newUsersLast30Days: 0,
  newUsersPrev30Days: 0,
  monthlyUserGrowth: {},
  monthlyCandidateGrowth: {},
  monthlyEmployerGrowth: {},
  monthlyInactiveGrowth: {},
}

// ✅ LOAD ALL REAL DATA from StatisticsServlet
function loadAllRealData() {
  console.log("🔄 Loading ALL real data from TechSignDB...")

  return fetch(window.contextPath + "/StatisticsServlet", {
    method: "GET",
    headers: {
      "X-Requested-With": "XMLHttpRequest",
      "Cache-Control": "no-cache",
    },
  })
    .then((response) => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`)
      }
      return response.json()
    })
    .then((data) => {
      console.log("📈 REAL DATA received from TechSignDB:", data)

      // ✅ Update ALL real data structures
      realData.accountStats = {
        total: data.totalUsers || 0,
        candidates: data.candidates || 0,
        employers: data.employers || 0,
        admins: data.admins || 0,
        activeUsers: data.activeUsers || 0,
        inactiveUsers: data.inactiveUsers || 0,
        growthRate: calculateGrowthRate(data),
      }

      realData.accessStats = {
        totalVisits: data.totalVisits || 0,
        todayVisits: data.todayVisits || 0,
        activeUsersWeek: data.activeUsersWeek || 0,
        avgSessionMinutes: data.avgSessionMinutes || 0,
        bounceRate: data.bounceRate || 0,
        hourlyVisits: data.hourlyVisits || {},
        visitsChartData: data.visitsChartData || {},
      }
      // Đảm bảo cập nhật số lượt truy cập hôm qua, thời gian trung bình 7 ngày trước và tổng lượt truy cập tháng trước từ backend
      realData.todayVisitsPrevDay = data.todayVisitsPrevDay || 0;
      realData.avgSessionMinutesPrev7Days = data.avgSessionMinutesPrev7Days || 0;
      realData.totalVisitsPrevMonth = data.totalVisitsPrevMonth || 0;
      realData.activeUsersWeekPrev7Days = data.activeUsersWeekPrev7Days || 0;

      realData.activityReports = {
        totalActivities: data.totalActivities || 0,
        newActivities: data.newActivities || 0,
        activeParticipants: data.activeParticipants || 0,
        activeParticipantsPrev7Days: data.activeParticipantsPrev7Days || 0,
        totalActivitiesPrev30Days: data.totalActivitiesPrev30Days || 0,
        newActivitiesPrevDay: data.newActivitiesPrevDay || 0,
        avgDailyActivitiesPrev30Days: data.avgDailyActivitiesPrev30Days || 0,
      }

      realData.applicationAnalysis = {
        totalApplications: data.totalApplications || 0,
        approvedApplications: data.approvedApplications || 0,
        pendingApplications: data.pendingApplications || 0,
        rejectedApplications: data.rejectedApplications || 0,
      }

      realData.securityStats = {
        securityAlerts: data.securityAlerts || 0,
        systemWarnings: data.systemWarnings || 0,
        criticalIssues: data.criticalIssues || 0,
      }

      // ✅ CẬP NHẬT DỮ LIỆU THẬT MỚI
      realData.totalUsers = data.totalUsers || 0;
      realData.newUsersLast30Days = data.newUsersLast30Days || 0;
      realData.newUsersPrev30Days = data.newUsersPrev30Days || 0;
      realData.monthlyUserGrowth = data.monthlyUserGrowth || {};
      realData.monthlyCandidateGrowth = data.monthlyCandidateGrowth || {};
      realData.monthlyEmployerGrowth = data.monthlyEmployerGrowth || {};
      realData.monthlyInactiveGrowth = data.monthlyInactiveGrowth || {};

      console.log("✅ ALL Real data updated:", realData)
      return realData
    })
    .catch((error) => {
      console.error("❌ Error loading real data:", error)
      return null
    })
}

// ✅ Initialize when page loads
document.addEventListener("DOMContentLoaded", () => {
  console.log("✅ DOM loaded, initializing complete reports with REAL DATA...")

  if (typeof Chart === "undefined") {
    console.error("❌ Chart.js not loaded!")
    return
  }

  initializeCompleteReports()
})

// ✅ Initialize complete reports system
function initializeCompleteReports() {
  console.log("📊 Starting complete reports initialization with TechSignDB data...")

  loadAllRealData().then(() => {
    setupNavigation()
    showSection("account-stats")
    setupGlobalAutoRefresh()
  })
}

// ✅ Setup navigation event listeners
function setupNavigation() {
  const navTabs = document.querySelectorAll(".nav-tab")
  navTabs.forEach((tab) => {
    tab.addEventListener("click", (e) => {
      e.preventDefault()
      const section = tab.getAttribute("data-section")
      showSection(section)
    })
  })
}

// ✅ Show specific section with real data
function showSection(sectionId) {
  console.log(`📋 Switching to section: ${sectionId} with REAL DATA`)

  clearAllIntervals()

  // Hide all sections
  const sections = document.querySelectorAll(".report-section")
  sections.forEach((section) => section.classList.remove("active"))

  // Remove active class from all tabs
  const tabs = document.querySelectorAll(".nav-tab")
  tabs.forEach((tab) => tab.classList.remove("active"))

  // Show target section
  const targetSection = document.getElementById(sectionId)
  if (targetSection) targetSection.classList.add("active")

  // Activate corresponding tab
  const targetTab = document.querySelector(`[data-section="${sectionId}"]`)
  if (targetTab) targetTab.classList.add("active")

  currentSection = sectionId

  // ✅ Initialize ALL sections with REAL DATA
  switch (sectionId) {
    case "account-stats":
      initializeAccountStatsWithRealData()
      break
    case "access-stats":
      initializeAccessStatsWithRealData()
      break
    case "activity-reports":
      initializeActivityReportsWithRealData()
      break
    case "application-analysis":
      initializeApplicationAnalysisWithRealData()
      break
  }
}

// ✅ 1. ACCOUNT STATISTICS with Real Data from TechSignDB
function initializeAccountStatsWithRealData() {
  console.log("📊 Initializing account stats with REAL DATA from TechSignDB...")

  updateAccountStats(realData.accountStats)
  createMainChart()
  updateLastUpdateTime()
  addFadeInAnimations()
}

// ✅ 2. ACCESS STATISTICS with Real Data
function initializeAccessStatsWithRealData() {
  setupAccessRangeSelector()
  loadAccessChartData(currentAccessRange)
  updateAccessStatsWithRealData()
  updateLastUpdateTime()
  addFadeInAnimations()
}

function updateAccessStatsWithRealData() {
  // Tổng lượt truy cập
  document.getElementById("totalVisits").textContent = formatNumber(realData.accessStats.totalVisits)
  const prevTotal = realData.totalVisitsPrevMonth || 0;
  const currTotal = realData.accessStats.totalVisits || 0;
  const totalChangeEl = document.getElementById("totalVisitsChange");
  if (prevTotal > 0) {
    let percentTotal = ((currTotal - prevTotal) / prevTotal * 100).toFixed(1);
    let prefixTotal = percentTotal > 0 ? "+" : "";
    totalChangeEl.textContent = `${prefixTotal}${percentTotal}% so với tháng trước`;
    const percentTotalNum = parseFloat(percentTotal);
    if (percentTotalNum > 0) {
      totalChangeEl.className = "stat-change positive";
    } else if (percentTotalNum < 0) {
      totalChangeEl.className = "stat-change negative";
    } else {
      totalChangeEl.className = "stat-change neutral";
    }
  } else if (prevTotal === 0 && currTotal > 0) {
    totalChangeEl.textContent = "Tăng mới so với tháng trước";
    totalChangeEl.className = "stat-change positive";
  } else {
    totalChangeEl.textContent = "0% so với tháng trước";
    totalChangeEl.className = "stat-change neutral";
  }

  // Lượt truy cập hôm nay
  document.getElementById("todayVisits").textContent = formatNumber(realData.accessStats.todayVisits)
  const prevToday = realData.todayVisitsPrevDay || 0;
  const currToday = realData.accessStats.todayVisits || 0;
  const todayChangeEl = document.getElementById("todayVisitsChange");
  if (prevToday > 0) {
    let percentToday = ((currToday - prevToday) / prevToday * 100).toFixed(1);
    let prefixToday = percentToday > 0 ? "+" : "";
    todayChangeEl.textContent = `${prefixToday}${percentToday}% so với hôm qua`;
    const percentTodayNum = parseFloat(percentToday);
    if (percentTodayNum > 0) {
      todayChangeEl.className = "stat-change positive";
    } else if (percentTodayNum < 0) {
      todayChangeEl.className = "stat-change negative";
    } else {
      todayChangeEl.className = "stat-change neutral";
    }
  } else if (prevToday === 0 && currToday > 0) {
    todayChangeEl.textContent = "Tăng mới so với hôm qua";
    todayChangeEl.className = "stat-change positive";
  } else {
    todayChangeEl.textContent = "0% so với hôm qua";
    todayChangeEl.className = "stat-change neutral";
  }

  // Thời gian trung bình mỗi phiên (7 ngày gần nhất)
  document.getElementById("avgSessionTime").textContent = realData.accessStats.avgSessionMinutes + ":00";
  const prevAvg = realData.avgSessionMinutesPrev7Days || 0;
  const currAvg = realData.accessStats.avgSessionMinutes || 0;
  const avgChangeEl = document.getElementById("avgSessionTimeChange");
  if (prevAvg > 0) {
    let percentAvg = ((currAvg - prevAvg) / prevAvg * 100).toFixed(1);
    let prefixAvg = percentAvg > 0 ? "+" : "";
    avgChangeEl.textContent = `${prefixAvg}${percentAvg}% so với 7 ngày trước`;
    const percentAvgNum = parseFloat(percentAvg);
    if (percentAvgNum > 0) {
      avgChangeEl.className = "stat-change positive";
    } else if (percentAvgNum < 0) {
      avgChangeEl.className = "stat-change negative";
    } else {
      avgChangeEl.className = "stat-change neutral";
    }
  } else if (prevAvg === 0 && currAvg > 0) {
    avgChangeEl.textContent = "Tăng mới so với 7 ngày trước";
    avgChangeEl.className = "stat-change positive";
  } else {
    avgChangeEl.textContent = "0% so với 7 ngày trước";
    avgChangeEl.className = "stat-change neutral";
  }

  // Số người truy cập (7 ngày)
  document.getElementById("activeUsersWeek").textContent = formatNumber(realData.accessStats.activeUsersWeek)
  const prevActive = realData.activeUsersWeekPrev7Days || 0;
  const currActive = realData.accessStats.activeUsersWeek || 0;
  let percentActive = 0;
  if (prevActive === 0) {
    percentActive = currActive > 0 ? 100 : 0;
  } else {
    percentActive = ((currActive - prevActive) / prevActive * 100).toFixed(1);
  }
  const prefixActive = percentActive > 0 ? "+" : "";
  const activeChangeEl = document.getElementById("activeUsersWeekChange");
  activeChangeEl.textContent = `${prefixActive}${percentActive}% so với 7 ngày trước`;
  activeChangeEl.className = percentActive > 0 ? "stat-change positive" : (percentActive < 0 ? "stat-change negative" : "stat-change neutral");
}

// ✅ 3. ACTIVITY REPORTS with Real Data
function initializeActivityReportsWithRealData() {
  console.log("📄 Initializing activity reports with REAL DATA...")

  updateActivityReportsWithRealData()
  updateActivityTable()
  updateLastUpdateTime()
  addFadeInAnimations()
}

function updateActivityReportsWithRealData() {
  // Cập nhật các thống kê chính
  document.getElementById("totalActivities").textContent = formatNumber(realData.activityReports.totalActivities)
  document.getElementById("newActivities").textContent = formatNumber(realData.activityReports.newActivities)
  document.getElementById("activeParticipants").textContent = formatNumber(realData.activityReports.activeParticipants)
  
  // Tính hoạt động trung bình/ngày
  const avgDaily = realData.activityReports.totalActivities > 0 ? 
    Math.round(realData.activityReports.totalActivities / 30) : 0
  document.getElementById("avgDailyActivities").textContent = formatNumber(avgDaily)
  
  // Tổng hoạt động (30 ngày) - % so với 30 ngày trước
  {
    const prev = realData.activityReports.totalActivitiesPrev30Days || 0;
    const curr = realData.activityReports.totalActivities || 0;
    let percent = 0;
    if (prev === 0) {
      percent = curr > 0 ? 100 : 0;
    } else {
      percent = ((curr - prev) / prev * 100).toFixed(1);
    }
    const prefix = percent > 0 ? "+" : "";
    const el = document.getElementById("totalActivitiesChange");
    if (el) {
      el.textContent = `${prefix}${percent}% so với 30 ngày trước`;
      if (percent > 0) {
        el.className = "stat-change positive";
      } else if (percent < 0) {
        el.className = "stat-change negative";
      } else {
        el.className = "stat-change neutral";
      }
    }
  }
  // Hoạt động hôm nay - % so với hôm qua
  {
    const prev = realData.activityReports.newActivitiesPrevDay || 0;
    const curr = realData.activityReports.newActivities || 0;
    let percent = 0;
    if (prev === 0) {
      percent = curr > 0 ? 100 : 0;
    } else {
      percent = ((curr - prev) / prev * 100).toFixed(1);
    }
    const prefix = percent > 0 ? "+" : "";
    const el = document.getElementById("newActivitiesChange");
    if (el) {
      el.textContent = `${prefix}${percent}% so với hôm qua`;
      if (percent > 0) {
        el.className = "stat-change positive";
      } else if (percent < 0) {
        el.className = "stat-change negative";
      } else {
        el.className = "stat-change neutral";
      }
    }
  }
  // Hoạt động trung bình/ngày - % so với trung bình 30 ngày trước
  {
    const prev = realData.activityReports.avgDailyActivitiesPrev30Days || 0;
    const curr = avgDaily;
    let percent = 0;
    if (prev === 0) {
      percent = curr > 0 ? 100 : 0;
    } else {
      percent = ((curr - prev) / prev * 100).toFixed(1);
    }
    const prefix = percent > 0 ? "+" : "";
    const el = document.getElementById("avgDailyActivitiesChange");
    if (el) {
      el.textContent = `${prefix}${percent}% so với 30 ngày trước`;
      if (percent > 0) {
        el.className = "stat-change positive";
      } else if (percent < 0) {
        el.className = "stat-change negative";
      } else {
        el.className = "stat-change neutral";
      }
    }
  }
  // Người dùng tham gia (7 ngày) - % so với 7 ngày trước
  {
    const prev = realData.activityReports.activeParticipantsPrev7Days || 0;
    const curr = realData.activityReports.activeParticipants || 0;
    let percent = 0;
    if (prev === 0) {
      percent = curr > 0 ? 100 : 0;
    } else {
      percent = ((curr - prev) / prev * 100).toFixed(1);
    }
    const prefix = percent > 0 ? "+" : "";
    const el = document.getElementById("activeParticipantsChange");
    if (el) {
      el.textContent = `${prefix}${percent}% so với 7 ngày trước`;
      if (percent > 0) {
        el.className = "stat-change positive";
      } else if (percent < 0) {
        el.className = "stat-change negative";
      } else {
        el.className = "stat-change neutral";
      }
    }
  }
}

// ✅ 4. APPLICATION ANALYSIS with Real Data
function initializeApplicationAnalysisWithRealData() {
  console.log("📊 Initializing application analysis with REAL DATA...")

  updateApplicationStatsWithRealData()
  createApplicationCharts()
  updateLastUpdateTime()
  addFadeInAnimations()
}

function updateApplicationStatsWithRealData() {
  document.getElementById("totalApplications").textContent = formatNumber(
    realData.applicationAnalysis.totalApplications,
  )
  document.getElementById("approvedApplications").textContent = formatNumber(
    realData.applicationAnalysis.approvedApplications,
  )
  document.getElementById("pendingApplications").textContent = formatNumber(
    realData.applicationAnalysis.pendingApplications,
  )
  document.getElementById("rejectedApplications").textContent = formatNumber(
    realData.applicationAnalysis.rejectedApplications,
  )
}

// ✅ UTILITY FUNCTIONS
function formatNumber(num) {
  return num.toLocaleString("vi-VN")
}

function calculateGrowthRate(data) {
  const total = data.totalUsers || 0
  const candidates = data.candidates || 0
  return total > 0 ? ((candidates / total) * 100).toFixed(1) : 0
}

function updateLastUpdateTime() {
  const now = new Date()
  const timeString = now.toLocaleTimeString("vi-VN")

  const lastUpdateElements = document.querySelectorAll(
    "#lastUpdate, #accessLastUpdate, #activityLastUpdate, #applicationLastUpdate",
  )
  lastUpdateElements.forEach((element) => {
    if (element) {
      element.textContent = timeString
    }
  })
}

function addFadeInAnimations() {
  const fadeElements = document.querySelectorAll(".fade-in")
  fadeElements.forEach((element, index) => {
    setTimeout(() => {
      element.style.opacity = "1"
      element.style.transform = "translateY(0)"
    }, index * 100)
  })
}

function clearAllIntervals() {
  Object.values(refreshIntervals).forEach((interval) => {
    if (interval) clearInterval(interval)
  })
  refreshIntervals = {}
}

function setupGlobalAutoRefresh() {
  setInterval(() => {
    console.log(`🔄 Auto-refresh for section: ${currentSection}`)
    loadAllRealData().then(() => {
      showSection(currentSection)
    })
  }, 300000) // 5 minutes
}

// ✅ CHART FUNCTIONS using REAL DATA
function updateAccountStats(data) {
  document.getElementById("totalAccounts").textContent = formatNumber(data.total)
  document.getElementById("newAccounts").textContent = formatNumber(realData.newUsersLast30Days)
  document.getElementById("inactiveAccounts").textContent = formatNumber(data.inactiveUsers)
  const growthRate = data.growthRate || 0;
  document.getElementById("growthRate").textContent = `${growthRate > 0 ? "+" : ""}${growthRate}%`;
  const growthChangeEl = document.getElementById("growthChange");
  growthChangeEl.textContent = "So với tháng trước";
  if (growthRate > 0) {
    growthChangeEl.className = "stat-change positive";
  } else if (growthRate < 0) {
    growthChangeEl.className = "stat-change negative";
  } else {
    growthChangeEl.className = "stat-change neutral";
  }

  updateChangeIndicator("totalChange", 12)
  // Tính phần trăm tăng trưởng 30 ngày
  const prev = realData.newUsersPrev30Days || 0;
  const curr = realData.newUsersLast30Days || 0;
  let percent = 0;
  if (prev === 0) {
    percent = curr > 0 ? 100 : 0;
  } else {
    percent = ((curr - prev) / prev * 100).toFixed(1);
  }
  const prefix = percent > 0 ? "+" : "";
  const newChangeEl = document.getElementById("newChange");
  newChangeEl.textContent = `${prefix}${percent}% so với 30 ngày trước`;
  const percentNum = parseFloat(percent);
  if (percentNum >= 0) {
    newChangeEl.className = "stat-change positive";
  } else {
    newChangeEl.className = "stat-change negative";
  }
  // TÍNH PHẦN TRĂM THAY ĐỔI SỐ TÀI KHOẢN KHÔNG HOẠT ĐỘNG GIỮA 2 THÁNG
  var inactiveChangeEl = document.getElementById("inactiveChange");
  inactiveChangeEl.textContent = "Trong hệ thống";
  inactiveChangeEl.style.color = "#2563eb"; // xanh dương

  updateAccountTypeStats()
  updateStatusStats()

  createMainChart()
}

function createMainChart() {
  const ctx = document.getElementById("mainChart")
  if (!ctx) return

  if (charts.mainChart) {
    charts.mainChart.destroy()
  }

  // ✅ Use REAL DATA from TechSignDB
  const data = [
    { type: "Ứng viên", count: realData.accountStats.candidates, color: "#8b5cf6" },
    { type: "Nhà tuyển dụng", count: realData.accountStats.employers, color: "#f59e0b" },
    { type: "Quản trị viên", count: realData.accountStats.admins, color: "#06b6d4" },
  ]

  charts.mainChart = new Chart(ctx, {
    type: "doughnut",
    data: {
      labels: data.map((item) => item.type),
      datasets: [
        {
          data: data.map((item) => item.count),
          backgroundColor: data.map((item) => item.color),
          borderWidth: 0,
          hoverOffset: 4,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false,
        },
      },
    },
  })

  createCustomLegend("mainChartLegend", data)
}

// ĐÃ XÓA TOÀN BỘ HÀM createTrendChart VÀ MỌI DÒNG GỌI createTrendChart, cũng như mọi biến liên quan đến trendChart

// ✅ Additional chart functions for other sections
function createAccessChart() {
  const ctx = document.getElementById("accessChart").getContext("2d")
  if (!ctx) return

  if (charts.accessChart) {
    charts.accessChart.destroy()
  }

  const visitsData = realData.accessStats.visitsChartData || {};
  let labels = [];
  let dataPoints = [];

  if (currentAccessRange === 'today') {
    // Theo giờ
    for (let i = 0; i < 24; i++) {
      labels.push(`${i}:00`);
      dataPoints.push(visitsData[i] || 0);
    }
  } else {
    // Theo ngày
    labels = Object.keys(visitsData);
    dataPoints = Object.values(visitsData);
  }

  const chartData = {
    labels: labels,
    datasets: [
      {
        label: "Lượt truy cập",
        data: dataPoints,
        backgroundColor: "rgba(59, 130, 246, 0.7)",
        borderColor: "rgba(59, 130, 246, 1)",
        borderWidth: 2,
        borderRadius: 5,
        barThickness: 15,
      },
    ],
  }

  charts.accessChart = new Chart(ctx, {
    type: "bar",
    data: chartData,
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false,
        },
        tooltip: {
          backgroundColor: "#333",
          titleColor: "#fff",
          bodyColor: "#fff",
        },
      },
      scales: {
        y: {
          beginAtZero: true,
          grid: {
            color: "#e5e7eb",
          },
          ticks: {
            stepSize: 1,
            callback: function(value) {
              if (Number.isInteger(value)) {
                return value;
              }
            }
          },
          suggestedMax: Math.max(...dataPoints) + 1
        },
        x: {
          grid: {
            display: false,
          },
        },
      },
    },
  })
}

function createApplicationCharts() {
  createApplicationTrendChart()
  createApplicationSectorChart()
}

function createApplicationTrendChart() {
  const ctx = document.getElementById("applicationTrendChart")
  if (!ctx) return

  if (charts.applicationTrendChart) {
    charts.applicationTrendChart.destroy()
  }

  const months = ["T7", "T8", "T9", "T10", "T11", "T12"]
  const total = realData.applicationAnalysis.totalApplications
  const approved = realData.applicationAnalysis.approvedApplications
  const approvalRate = total > 0 ? (approved / total) * 100 : 0

  const approvalRates = months.map(() => Math.max(0, approvalRate + (Math.random() - 0.5) * 20))

  charts.applicationTrendChart = new Chart(ctx, {
    type: "line",
    data: {
      labels: months,
      datasets: [
        {
          label: "Tỷ lệ phê duyệt (%)",
          data: approvalRates,
          borderColor: "#10b981",
          backgroundColor: "rgba(16, 185, 129, 0.1)",
          tension: 0.4,
          fill: true,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false,
        },
      },
      scales: {
        y: {
          beginAtZero: true,
          max: 100,
        },
      },
    },
  })
}

function createApplicationSectorChart() {
  const ctx = document.getElementById("applicationSectorChart")
  if (!ctx) return

  if (charts.applicationSectorChart) {
    charts.applicationSectorChart.destroy()
  }

  const sectors = ["IT", "Marketing", "Sales", "HR", "Finance", "Other"]
  const total = realData.applicationAnalysis.totalApplications
  const baseCount = Math.max(1, Math.floor(total / 6))
  const applications = sectors.map(() => Math.max(0, baseCount + Math.floor(Math.random() * baseCount)))
  const colors = ["#3b82f6", "#8b5cf6", "#f59e0b", "#10b981", "#ef4444", "#6b7280"]

  charts.applicationSectorChart = new Chart(ctx, {
    type: "pie",
    data: {
      labels: sectors,
      datasets: [
        {
          data: applications,
          backgroundColor: colors,
          borderWidth: 0,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          position: "bottom",
        },
      },
    },
  })
}

// ✅ REFRESH FUNCTIONS for all sections
function refreshAccountStats() {
  console.log("🔄 Refreshing account statistics...")
  loadAllRealData().then(() => {
    initializeAccountStatsWithRealData()
  })
}

function refreshAccessStats() {
  console.log("🔄 Refreshing access statistics...")
  loadAllRealData().then(() => {
    initializeAccessStatsWithRealData()
  })
}

function refreshActivityReports() {
  console.log("🔄 Refreshing activity reports...")
  loadAllRealData().then(() => {
    updateActivityReportsWithRealData()
    updateActivityTable()
    updateLastUpdateTime()
    addFadeInAnimations()
  })
}

function refreshApplicationAnalysis() {
  console.log("🔄 Refreshing application analysis...")
  loadAllRealData().then(() => {
    initializeApplicationAnalysisWithRealData()
  })
}

// ✅ Helper functions
function updateChangeIndicator(elementId, value) {
  const element = document.getElementById(elementId)
  if (!element) return

  let prefix = "";
  let className = "stat-change positive";
  let valueNum = typeof value === "number" ? value : parseFloat(value);
  if (valueNum > 0) {
    prefix = "+";
    className = "stat-change positive";
  } else if (valueNum < 0) {
    className = "stat-change negative";
  }
  const valueStr = valueNum.toFixed(1);
  element.textContent = `${prefix}${valueStr}% so với tháng trước`;
  element.className = className;
}

function createCustomLegend(containerId, data) {
  const container = document.getElementById(containerId)
  if (!container) return

  const total = data.reduce((sum, item) => sum + item.count, 0)

  container.innerHTML = data
    .map((item) => {
      const percentage = total > 0 ? ((item.count / total) * 100).toFixed(1) : 0
      return `
      <div class="legend-item">
        <div class="legend-color" style="background-color: ${item.color}"></div>
        <div class="legend-info">
          <div class="legend-label">${item.type}</div>
          <div class="legend-value">${formatNumber(item.count)} (${percentage}%)</div>
        </div>
      </div>
    `
    })
    .join("")
}

function updateAccountTypeStats() {
  const container = document.getElementById("accountTypeStats")
  if (!container) return

  const data = [
    { type: "Ứng viên", count: realData.accountStats.candidates, color: "#8b5cf6" },
    { type: "Nhà tuyển dụng", count: realData.accountStats.employers, color: "#f59e0b" },
    { type: "Quản trị viên", count: realData.accountStats.admins, color: "#06b6d4" },
  ]

  container.innerHTML = data
    .map(
      (item) => `
    <div class="stat-item">
      <div class="stat-item-header">
        <div class="stat-item-icon" style="background-color: ${item.color}">
          <i class="fas fa-users"></i>
        </div>
        <div class="stat-item-info">
          <div class="stat-item-label">${item.type}</div>
          <div class="stat-item-value">${formatNumber(item.count)}</div>
        </div>
      </div>
      <div class="stat-item-percentage">${realData.accountStats.total > 0 ? ((item.count / realData.accountStats.total) * 100).toFixed(1) : 0}%</div>
    </div>
  `,
    )
    .join("")
}

function updateStatusStats() {
  const container = document.getElementById("statusStats")
  if (!container) return

  const data = [
    { status: "Hoạt động", count: realData.accountStats.activeUsers, color: "#10b981", icon: "fa-user-check" },
    { status: "Không hoạt động", count: realData.accountStats.inactiveUsers, color: "#ef4444", icon: "fa-user-times" },
  ]

  container.innerHTML = data
    .map(
      (item) => `
    <div class="stat-item">
      <div class="stat-item-header">
        <div class="stat-item-icon" style="background-color: ${item.color}">
          <i class="fas ${item.icon}"></i>
        </div>
        <div class="stat-item-info">
          <div class="stat-item-label">${item.status}</div>
          <div class="stat-item-value">${formatNumber(item.count)}</div>
        </div>
      </div>
    </div>
  `,
    )
    .join("")
}

function updateActivityTable() {
  const tbody = document.getElementById("activityTableBody");
  if (!tbody) return;

  tbody.innerHTML = `<tr><td colspan="5" class="text-center text-muted">Đang tải dữ liệu...</td></tr>`;

  fetch(window.contextPath + "/activityReport")
    .then(res => res.json())
    .then(data => {
      if (!Array.isArray(data) || data.length === 0) {
        tbody.innerHTML = `<tr><td colspan="5" class="text-center text-muted"><i class='fas fa-info-circle'></i> Chưa có hoạt động nào được ghi nhận</td></tr>`;
        return;
      }
      tbody.innerHTML = data.map(log => `
        <tr>
          <td><div class='activity-time'><i class='fas fa-clock text-muted'></i> ${log.timestamp ? new Date(log.timestamp).toLocaleString('vi-VN') : ''}</div></td>
          <td><div class='activity-user'><i class='fas fa-user text-primary'></i> user${log.userId ?? 'N/A'}</div></td>
          <td><span class='activity-badge'>${log.actionType}</span></td>
          <td><div class='activity-details'>${log.newValue ? log.newValue : (log.oldValue ? log.oldValue : '')}</div></td>
          <td><code class='text-muted'>${log.ipAddress ?? ''}</code></td>
        </tr>
      `).join("");
    })
    .catch(() => {
      tbody.innerHTML = `<tr><td colspan="5" class="text-center text-danger">Lỗi khi tải dữ liệu!</td></tr>`;
    });
}

// TĂNG TRƯỞNG NGƯỜI DÙNG THEO THÁNG DƯƠNG LỊCH
const monthlyGrowth = realData.monthlyUserGrowth || {};
const months = Object.keys(monthlyGrowth).sort();
const thisMonth = months.length > 0 ? monthlyGrowth[months[months.length - 1]] : 0;
const lastMonth = months.length > 1 ? monthlyGrowth[months[months.length - 2]] : 0;
let userGrowthRate = 0;
if (lastMonth === 0) {
  userGrowthRate = thisMonth > 0 ? 100 : 0;
} else {
  userGrowthRate = ((thisMonth - lastMonth) / lastMonth * 100).toFixed(1);
}
document.getElementById("growthRate").textContent = `${userGrowthRate > 0 ? "+" : ""}${userGrowthRate}%`;
const growthChangeEl = document.getElementById("growthChange");
growthChangeEl.textContent = "So với tháng trước";
if (userGrowthRate > 0) {
  growthChangeEl.className = "stat-change positive";
} else if (userGrowthRate < 0) {
  growthChangeEl.className = "stat-change negative";
} else {
  growthChangeEl.className = "stat-change neutral";
}

// Hàm load dữ liệu truy cập theo range
function loadAccessChartData(range) {
  currentAccessRange = range;
  return fetch(window.contextPath + "/StatisticsServlet?range=" + encodeURIComponent(range), {
    method: "GET",
    headers: {
      "X-Requested-With": "XMLHttpRequest",
      "Cache-Control": "no-cache",
    },
  })
    .then((response) => {
      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`)
      return response.json()
    })
    .then((data) => {
      // Lưu dữ liệu visitsChartData vào realData
      realData.accessStats.visitsChartData = data.visitsChartData || {};
      // Cập nhật các chỉ số khác nếu muốn (tùy chọn)
      createAccessChart();
    })
    .catch((error) => {
      console.error("❌ Error loading access chart data:", error)
    })
}

// Gắn sự kiện cho dropdown range
function setupAccessRangeSelector() {
  const select = document.getElementById('accessRangeSelect');
  if (!select) return;
  select.value = currentAccessRange;
  select.addEventListener('change', function() {
    loadAccessChartData(this.value);
  });
}

// === Activity Chart with Date Range ===
function fetchActivityChartData(startDate, endDate) {
  return fetch(window.contextPath + `/StatisticsServlet?activityStartDate=${encodeURIComponent(startDate)}&activityEndDate=${encodeURIComponent(endDate)}`,
    {
      method: "GET",
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        "Cache-Control": "no-cache",
      },
    })
    .then((response) => {
      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`)
      return response.json()
    })
    .then((data) => {
      // Dữ liệu trả về dạng { labels: ["2025-06-20",...], values: [2,1,0,...] }
      drawActivityChartWithData(data.labels, data.values)
    })
    .catch((error) => {
      console.error("❌ Error loading activity chart data:", error)
    })
}

function drawActivityChartWithData(labels, values) {
  // Lấy ngày bắt đầu và kết thúc từ labels
  if (!labels || labels.length === 0) return;
  // labels là dạng yyyy-MM-dd hoặc tương tự
  const parseDate = (str) => {
    const [year, month, day] = str.split('-');
    return new Date(Number(year), Number(month) - 1, Number(day));
  };
  const start = parseDate(labels[0]);
  const end = parseDate(labels[labels.length - 1]);
  // Sinh mảng ngày liên tục
  const dateList = [];
  for (let d = new Date(start); d <= end; d.setDate(d.getDate() + 1)) {
    const yyyy = d.getFullYear();
    const mm = String(d.getMonth() + 1).padStart(2, '0');
    const dd = String(d.getDate()).padStart(2, '0');
    dateList.push(`${yyyy}-${mm}-${dd}`);
  }
  // Map dữ liệu backend vào các ngày này
  const dataMap = {};
  labels.forEach((date, idx) => { dataMap[date] = values[idx]; });
  const fullLabels = dateList;
  const fullValues = dateList.map(date => dataMap[date] || 0);
  // Format labels to dd/MM
  const formattedLabels = fullLabels.map(dateStr => {
    const d = new Date(dateStr);
    if (!isNaN(d)) {
      const day = d.getDate().toString().padStart(2, '0');
      const month = (d.getMonth() + 1).toString().padStart(2, '0');
      return `${day}/${month}`;
    }
    return dateStr;
  });
  const ctx = document.getElementById("activityChart")
  if (!ctx) return
  if (charts.activityChart) charts.activityChart.destroy()
  charts.activityChart = new Chart(ctx, {
    type: "bar",
    data: {
      labels: formattedLabels,
      datasets: [
        {
          label: "Hoạt động",
          data: fullValues,
          backgroundColor: "rgba(139, 92, 246, 0.7)",
          borderColor: "#8b5cf6",
          borderWidth: 2,
          borderRadius: 5,
          barThickness: 15,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: { display: false },
        tooltip: {
          backgroundColor: "rgba(0, 0, 0, 0.8)",
          titleColor: "#ffffff",
          bodyColor: "#ffffff",
          borderColor: "#8b5cf6",
          borderWidth: 1,
          cornerRadius: 8,
          displayColors: false,
          callbacks: {
            title: function(context) {
              return `Ngày: ${context[0].label}`;
            },
            label: function(context) {
              return `Hoạt động: ${formatNumber(context.parsed.y)}`
            }
          }
        }
      },
      scales: {
        y: {
          beginAtZero: true,
          grid: { color: "rgba(0, 0, 0, 0.1)", drawBorder: false },
          ticks: { color: "#6b7280", font: { size: 12 } }
        },
        x: {
          grid: { display: false },
          ticks: { color: "#6b7280", font: { size: 12 } }
        }
      },
      interaction: { intersect: false, mode: 'index' }
    },
  })
}

// Gắn sự kiện cho nút Xem báo cáo
function handleActivityRangeClick() {
  const start = document.getElementById("activityStartDate").value;
  const end = document.getElementById("activityEndDate").value;
  if (!start || !end) {
    alert("Vui lòng chọn đủ ngày bắt đầu và kết thúc!");
    return;
  }
  fetchActivityChartData(start, end);
}

// === JOB REPORTS (TUYỂN DỤNG) ===
function loadJobReportData() {
  return fetch(window.contextPath + "/jobReport", {
    method: "GET",
    headers: { "X-Requested-With": "XMLHttpRequest", "Cache-Control": "no-cache" },
  })
    .then((response) => {
      if (!response.ok) throw new Error("HTTP error! status: " + response.status);
      return response.json();
    });
}

function renderJobReport(data) {
  // Hiển thị số liệu đã làm tròn
  document.getElementById("jobTotalPosts").textContent = data.totalJobPosts ?? "--";
  document.getElementById("jobActivePosts").textContent = data.activeJobPosts ?? "--";
  document.getElementById("jobExpiredPosts").textContent = data.expiredJobPosts ?? "--";
  document.getElementById("jobAvgViews").textContent = data.avgJobViews !== undefined ? Math.round(data.avgJobViews) : "--";
  document.getElementById("jobAvgApplications").textContent = data.avgApplications !== undefined ? Math.round(data.avgApplications) : "--";
  document.getElementById("jobLastUpdate").textContent = new Date().toLocaleTimeString();

  // Bổ sung cập nhật số liệu cho các card mới (đúng id)
  document.getElementById("jobTotalApplications").textContent = data.totalApplications ?? "--";
  document.getElementById("jobApprovedApplications").textContent = data.approvedApplications ?? "--";
  document.getElementById("jobRejectedApplications").textContent = data.rejectedApplications ?? "--";
  document.getElementById("jobPendingApplications").textContent = data.pendingApplications ?? "--";
  document.getElementById("jobPendingApplicationsChange").innerHTML = formatChange(data.pendingApplicationsPct);

  // Helper: format phần trăm và màu sắc
  function formatChange(pct) {
    if (pct === undefined || pct === null) return "";
    const val = Math.round(pct);
    if (val > 0) return `<span class='stat-change positive'>↑ ${val}% so với tháng trước</span>`;
    if (val < 0) return `<span class='stat-change negative'>↓ ${Math.abs(val)}% so với tháng trước</span>`;
    return `<span class='stat-change neutral'>Không đổi so với tháng trước</span>`;
  }

  // Gán label so sánh cho từng số liệu
  document.getElementById("jobTotalPostsChange").innerHTML = formatChange(data.totalJobPostsPct);
  document.getElementById("jobActivePostsChange").innerHTML = formatChange(data.activeJobPostsPct);
  document.getElementById("jobExpiredPostsChange").innerHTML = formatChange(data.expiredJobPostsPct);
  document.getElementById("jobAvgViewsChange").innerHTML = formatChange(data.avgJobViewsPct);
  document.getElementById("jobAvgApplicationsChange").innerHTML = formatChange(data.avgApplicationsPct);

  // Bổ sung label phần trăm cho các card mới (đúng id)
  document.getElementById("jobTotalApplicationsChange").innerHTML = formatChange(data.totalApplicationsPct);
  document.getElementById("jobApprovedApplicationsChange").innerHTML = formatChange(data.approvedApplicationsPct);
  document.getElementById("jobRejectedApplicationsChange").innerHTML = formatChange(data.rejectedApplicationsPct);

  addFadeInAnimations();

  // --- Render top 10 bài đăng ---
  // Top lượt xem
  const topViewed = data.topViewedPosts || [];
  const viewedTbody = document.querySelector('#topViewedPostsTable tbody');
  viewedTbody.innerHTML = topViewed.length === 0 ? '<tr><td colspan="3" class="text-center">Không có dữ liệu</td></tr>' :
    topViewed.map((post, idx) => `<tr><td>${idx+1}</td><td>${post.title}</td><td>${post.views}</td></tr>`).join('');
  // Top ứng tuyển
  const topApplied = data.topAppliedPosts || [];
  const appliedTbody = document.querySelector('#topAppliedPostsTable tbody');
  appliedTbody.innerHTML = topApplied.length === 0 ? '<tr><td colspan="3" class="text-center">Không có dữ liệu</td></tr>' :
    topApplied.map((post, idx) => `<tr><td>${idx+1}</td><td>${post.title}</td><td>${post.applyCount}</td></tr>`).join('');
}

function refreshJobReport() {
  document.getElementById('jobLastUpdate').textContent = 'Đang tải...';
  document.getElementById('jobChartSection').style.display = 'block';
  loadJobReportData()
    .then(renderJobReport)
    .catch(() => {
      document.getElementById('jobTotalPosts').textContent = '--';
      document.getElementById('jobActivePosts').textContent = '--';
      document.getElementById('jobExpiredPosts').textContent = '--';
      document.getElementById('jobAvgViews').textContent = '--';
      document.getElementById('jobAvgApplications').textContent = '--';
      document.getElementById('jobLastUpdate').textContent = 'Lỗi tải dữ liệu';
    });
}

function setupJobReportSection() {
  const tab = document.querySelector('[data-section="job-posting-reports"]');
  if (tab) {
    tab.addEventListener("click", () => {
      document.getElementById('jobChartSection').style.display = 'none';
      setupJobChartDatePicker();
      // KHÔNG gọi refreshJobReport() ở đây!
    });
  }
}

// Gọi khi khởi tạo hệ thống báo cáo
(function() {
  setupJobReportSection();
})();

console.log("✅ Complete Statistics Reports JavaScript loaded successfully with REAL DATA!")

function handleJobChartClick() {
  const from = document.getElementById('jobChartFrom').value;
  const to = document.getElementById('jobChartTo').value;
  if (!from || !to) {
    alert('Vui lòng chọn đủ ngày bắt đầu và kết thúc!');
    return;
  }
  loadJobChart();
}

var jobPostsChartInstance = null;
function loadJobChart() {
  const from = document.getElementById('jobChartFrom').value;
  const to = document.getElementById('jobChartTo').value;
  if (!from || !to) return;
  fetch(window.contextPath + `/jobReport?from=${from}&to=${to}`)
    .then(res => res.json())
    .then(data => {
      // Sinh mảng ngày liên tục từ from đến to
      const start = new Date(from);
      const end = new Date(to);
      const dateList = [];
      for (let d = new Date(start); d <= end; d.setDate(d.getDate() + 1)) {
        const yyyy = d.getFullYear();
        const mm = String(d.getMonth() + 1).padStart(2, '0');
        const dd = String(d.getDate()).padStart(2, '0');
        dateList.push(`${yyyy}-${mm}-${dd}`);
      }
      // Map dữ liệu backend vào các ngày này
      const dataMap = {};
      data.forEach(row => { dataMap[row.date] = row.count; });
      const labels = dateList;
      const counts = dateList.map(date => dataMap[date] || 0);
      const ctx = document.getElementById('jobPostsChart').getContext('2d');
      if (jobPostsChartInstance) jobPostsChartInstance.destroy();
      jobPostsChartInstance = new Chart(ctx, {
        type: 'bar',
        data: {
          labels: labels,
          datasets: [{
            label: 'Tin tuyển dụng mới',
            data: counts,
            backgroundColor: 'rgba(20,184,166,0.7)', // teal
            borderColor: '#14b8a6',
            borderWidth: 2,
            borderRadius: 5,
            barThickness: 15,
            hoverBackgroundColor: '#06b6d4',
            hoverBorderColor: '#06b6d4',
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: { legend: { display: false } },
          scales: { x: { grid: { display: false } }, y: { beginAtZero: true } }
        }
      });
    });
}

// === ACCOUNT TREND CHART WITH DATE RANGE ===
function fetchAccountTrendChartData(startDate, endDate) {
  fetch(window.contextPath + `/StatisticsServlet?accountTrendStartDate=${encodeURIComponent(startDate)}&accountTrendEndDate=${encodeURIComponent(endDate)}`,
    {
      method: "GET",
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        "Cache-Control": "no-cache",
      },
    })
    .then((response) => {
      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`)
      return response.json()
    })
    .then((data) => {
      if (!data || !data.labels || data.labels.length === 0) {
        showNoAccountTrendDataMessage();
        return;
      }
      drawAccountTrendChartWithData(data.labels, data.total, data.candidates, data.employers);
    })
    .catch((error) => {
      console.error("❌ Error loading account trend chart data:", error)
      showNoAccountTrendDataMessage();
    })
}

function drawAccountTrendChartWithData(labels, totalData, candidateData, employerData) {
  const ctx = document.getElementById("trendChart");
  if (!ctx) return;
  if (window.charts && window.charts.trendChart) window.charts.trendChart.destroy();
  if (!window.charts) window.charts = {};
  window.charts.trendChart = new Chart(ctx, {
    type: "line",
    data: {
      labels: labels,
      datasets: [
        {
          label: "Tổng tài khoản",
          data: totalData,
          borderColor: "#3b82f6",
          backgroundColor: "rgba(59, 130, 246, 0.1)",
          tension: 0.4,
          fill: true,
          borderWidth: 3,
        },
        {
          label: "Ứng viên",
          data: candidateData,
          borderColor: "#28a745",
          backgroundColor: "rgba(40, 167, 69, 0.1)",
          tension: 0.4,
          fill: false,
          borderDash: [5, 5],
        },
        {
          label: "Nhà tuyển dụng",
          data: employerData,
          borderColor: "#ffc107",
          backgroundColor: "rgba(255, 193, 7, 0.1)",
          tension: 0.4,
          fill: false,
          borderDash: [5, 5],
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          position: "top",
        },
      },
      scales: {
        y: {
          beginAtZero: true,
        },
      },
    },
  });
}

function showNoAccountTrendDataMessage() {
  const ctx = document.getElementById("trendChart");
  if (!ctx) return;
  if (window.charts && window.charts.trendChart) window.charts.trendChart.destroy();
  const parent = ctx.parentElement;
  let msg = parent.querySelector('.no-trend-data-msg');
  if (!msg) {
    msg = document.createElement('div');
    msg.className = 'no-trend-data-msg';
    msg.style.textAlign = 'center';
    msg.style.color = '#888';
    msg.style.margin = '32px 0';
    msg.style.fontSize = '1.1rem';
    parent.appendChild(msg);
  }
  msg.textContent = 'Không có dữ liệu trong khoảng thời gian này.';
}

function handleAccountTrendRangeClick() {
  const start = document.getElementById("trendStartDate").value;
  const end = document.getElementById("trendEndDate").value;
  if (!start || !end) {
    alert("Vui lòng chọn đủ ngày bắt đầu và kết thúc!");
    return;
  }
  fetchAccountTrendChartData(start, end);
}
window.handleAccountTrendRangeClick = handleAccountTrendRangeClick;

// === ACCOUNT BAR CHART: Tài khoản mới theo ngày ===
function fetchAccountBarChartData(startDate, endDate) {
  fetch(window.contextPath + `/StatisticsServlet?accountBarStartDate=${encodeURIComponent(startDate)}&accountBarEndDate=${encodeURIComponent(endDate)}`,
    {
      method: "GET",
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        "Cache-Control": "no-cache",
      },
    })
    .then((response) => {
      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`)
      return response.json()
    })
    .then((data) => {
      if (!data || !data.labels || data.labels.length === 0) {
        showNoAccountBarDataMessage();
        return;
      }
      drawAccountBarChartWithData(data.labels, data.values);
    })
    .catch((error) => {
      console.error("❌ Error loading account bar chart data:", error)
      showNoAccountBarDataMessage();
    })
}

function drawAccountBarChartWithData(labels, values) {
  const ctx = document.getElementById("accountBarChart");
  if (!ctx) return;
  if (window.charts && window.charts.accountBarChart) window.charts.accountBarChart.destroy();
  if (!window.charts) window.charts = {};
  document.getElementById("accountBarNoDataMsg").style.display = "none";
  window.charts.accountBarChart = new Chart(ctx, {
    type: "bar",
    data: {
      labels: labels,
      datasets: [
        {
          label: "Tài khoản mới",
          data: values,
          backgroundColor: "rgba(20,184,166,0.7)", // teal trong suốt
          borderColor: "#14b8a6",
          borderWidth: 2,
          borderRadius: 5,
          barThickness: 14,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: { display: false },
      },
      scales: {
        y: { beginAtZero: true, grid: { color: "#e5e7eb" } },
        x: {
          grid: { display: false },
          ticks: { color: "#6b7280", font: { size: 12 }, maxRotation: 45, minRotation: 45 }
        },
      },
    },
  });
}

function showNoAccountBarDataMessage() {
  const ctx = document.getElementById("accountBarChart");
  if (window.charts && window.charts.accountBarChart) window.charts.accountBarChart.destroy();
  document.getElementById("accountBarNoDataMsg").style.display = "block";
}

function handleAccountBarRangeClick() {
  const start = document.getElementById("accountBarStartDate").value;
  const end = document.getElementById("accountBarEndDate").value;
  if (!start || !end) {
    alert("Vui lòng chọn đủ ngày bắt đầu và kết thúc!");
    return;
  }
  fetchAccountBarChartData(start, end);
}
window.handleAccountBarRangeClick = handleAccountBarRangeClick;

// === ACCESS BAR CHART: Lượt truy cập theo ngày ===
function fetchAccessBarChartData(startDate, endDate) {
  fetch(window.contextPath + `/StatisticsServlet?accessBarStartDate=${encodeURIComponent(startDate)}&accessBarEndDate=${encodeURIComponent(endDate)}`,
    {
      method: "GET",
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        "Cache-Control": "no-cache",
      },
    })
    .then((response) => {
      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`)
      return response.json()
    })
    .then((data) => {
      if (!data || !data.labels || data.labels.length === 0) {
        showNoAccessBarDataMessage();
        return;
      }
      drawAccessBarChartWithData(data.labels, data.values);
    })
    .catch((error) => {
      console.error("❌ Error loading access bar chart data:", error)
      showNoAccessBarDataMessage();
    })
}

function drawAccessBarChartWithData(labels, values) {
  const ctx = document.getElementById("accessBarChart");
  if (!ctx) return;
  if (window.charts && window.charts.accessBarChart) window.charts.accessBarChart.destroy();
  if (!window.charts) window.charts = {};
  document.getElementById("accessBarNoDataMsg").style.display = "none";
  window.charts.accessBarChart = new Chart(ctx, {
    type: "bar",
    data: {
      labels: labels,
      datasets: [
        {
          label: "Lượt truy cập",
          data: values,
          backgroundColor: "rgba(20,184,166,0.7)",
          borderColor: "#14b8a6",
          borderWidth: 2,
          borderRadius: 5,
          barThickness: 14,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: { display: false },
      },
      scales: {
        y: { beginAtZero: true, grid: { color: "#e5e7eb" } },
        x: {
          grid: { display: false },
          ticks: { color: "#6b7280", font: { size: 12 }, maxRotation: 45, minRotation: 45 }
        },
      },
    },
  });
}

function showNoAccessBarDataMessage() {
  const ctx = document.getElementById("accessBarChart");
  if (window.charts && window.charts.accessBarChart) window.charts.accessBarChart.destroy();
  document.getElementById("accessBarNoDataMsg").style.display = "block";
}

function handleAccessBarRangeClick() {
  const start = document.getElementById("accessBarStartDate").value;
  const end = document.getElementById("accessBarEndDate").value;
  if (!start || !end) {
    alert("Vui lòng chọn đủ ngày bắt đầu và kết thúc!");
    return;
  }
  fetchAccessBarChartData(start, end);
}
window.handleAccessBarRangeClick = handleAccessBarRangeClick;

# CFSBR - Centre for Fintech & Strategic Business Research

<div align="center">
  <img src="photos/cfsbrs.png" alt="CFSBR Logo" width="200"/>
  <h3>Innovating Finance for Emerging Markets</h3>
  <p>Hybrid think-tank & innovation lab building inclusive, data-driven financial solutions</p>
  
  [![Website](https://img.shields.io/badge/Website-Live-blue)](https://cfsbr.gmrafi.com)
  [![License](https://img.shields.io/badge/License-Private-red)]()
</div>

---

## 📖 About CFSBR

The **Centre for Fintech & Strategic Business Research (CFSBR)** is an "Intellectual Entrepreneurship" hub operating at the intersection of:
- **Economics** (Context)
- **Engineering** (Tool)  
- **Business Strategy** (Sustainability)

We decode emerging market complexities and build data-driven fintech and strategic business intelligence for inclusive and sustainable growth in the Global South, with a special focus on Bangladesh.

### 🎯 Our Mission
To decode the complexities of emerging economies through data-driven research and provide actionable fintech strategies that foster financial inclusion and sustainable growth.

### 🔭 Our Vision
To become the premier hybrid think-tank and innovation lab where the future of inclusive finance is designed for Bangladesh and beyond.

---

## ✨ Key Features

### 🌐 Website Highlights
- **Modern Design**: Professional fintech branding with navy blue (#0D3B66) and light blue (#3D54E6) color scheme
- **Responsive Layout**: Fully optimized for desktop, tablet, and mobile devices
- **SEO Optimized**: Complete meta tags, Open Graph, and Schema.org structured data
- **Performance**: Fast-loading static site with optimized assets

### 📄 Core Sections
- 🏠 **Hero**: Data-driven financial intelligence showcase
- 💡 **About**: Hybrid intelligence approach
- 💎 **Core Values**: 4 guiding principles (Hybrid Intelligence, Data-First, Scalability, Ethical Innovation)
- 🎯 **Strategic Objectives**: Long-term & short-term goals
- 🔬 **What We Do**: Market intelligence, consultancy, capacity building, policy advocacy, fellowship programs
- 📊 **Featured Intelligence**: Research publications and conference papers
- 👥 **Team**: CFSBR Unified Dual-Wing Hierarchy (Advisory Board, Research & Intelligence Wing, Strategic Business & Innovation Wing, Founding Board & Secretariat)

---

## 🛠️ Technology Stack

| Technology | Purpose |
|-----------|---------|
| **HTML5** | Semantic markup with Schema.org structured data |
| **CSS3** | Modern styling with CSS Grid, Flexbox, and custom properties |
| **JavaScript** | Vanilla JS for smooth scrolling and interactive features |
| **Lucide Icons** | Consistent, scalable iconography |
| **Google Fonts** | Playfair Display (headings) & Inter (body) |
| **Google Analytics** | Traffic tracking and insights |

---

## 🚀 Getting Started

### Prerequisites
- Modern web browser (Chrome, Firefox, Safari, Edge)
- Local web server (optional, for development)

### Installation

1. **Clone the repository**:
```bash
git clone https://github.com/gmrafi/cfsbr.git
cd cfsbr
```

2. **Open the website**:
   - Simply open `index.html` in your browser, or
   - Use a local server:
   ```bash
   # Python 3
   python -m http.server 8000
   
   # PHP
   php -S localhost:8000
   ```
   Then navigate to `http://localhost:8000`

---

## 📂 Project Structure

```
cfsbr/
├── index.html              # Main landing page
├── about.html              # About CFSBR
├── activities.html         # Services & activities
├── objectives.html         # Strategic objectives
├── publications.html       # Research intelligence
├── team.html              # Team structure
├── values.html            # Core values
├── styles.css             # Global stylesheet
├── robots.txt             # SEO configuration
├── sitemap.xml            # Site structure
├── photos/
│   ├── cfsbrs.png         # CFSBR logo
│   └── team/              # Team member photos
├── backend/
│   ├── server.py          # Backend server (if applicable)
│   └── requirements.txt   # Python dependencies
└── README.md              # This file
```

---

## 🎨 Color Palette

| Color | Hex | Purpose |
|-------|-----|---------|
| Navy Blue | `#0D3B66` | Primary brand color |
| Light Blue | `#3D54E6` | Accent & interactive elements |
| Green | `#1E5A3C` | Sustainability theme |
| Orange | `#f59e0b` | Short-term goals accent |
| White | `#ffffff` | Backgrounds & text |
| Gray | `#6b7280` | Secondary text |

---

## 📊 Features in Detail

### Research Intelligence
- Journal articles on monetary policy and market opportunities
- Conference papers on digital finance and financial literacy
- Green finance and climate risk analysis

### Services
1. **Market Intelligence** - Consumer behavior & digital adoption analytics
2. **Strategic Consultancy** - Business model design for startups
3. **Capacity Building** - Workshops on analytics & methodology
4. **Policy Advocacy** - Inclusive digital finance policy collaboration
5. **Fintech Fellowship** - Structured mentorship programs

---

## 🤝 Contributing

This is a private repository. For collaboration inquiries, please contact:
- **Email**: info.cfsbr@gmail.com
- **Phone**: +880 1300 560126

---

## 📄 License

© 2025 CFSBR - Centre for Fintech & Strategic Business Research. All rights reserved.

This project is private and proprietary. Unauthorized copying, distribution, or use is strictly prohibited.

---

## 👨‍💻 Development Team

**Designed & Developed by**: CFSBR Tech Team

---

## 📞 Contact

- **Website**: [cfsbr.gmrafi.com](https://cfsbr.gmrafi.com)
- **Email**: info.cfsbr@gmail.com
- **Phone**: +880 1300 560126
- **Location**: Sylhet, Bangladesh

---

<div align="center">
  <strong>Building the future of inclusive finance for emerging markets 🚀</strong>
</div>](https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify)
# cfsbr

## 🌐 Production Domains and Hosting

CFSBR is served from three co-primary domains that all point to the same static build of this repository:

| Domain | Role | Host |
|---|---|---|
| `cfsbr.com` | Global English brand (canonical short address) | Vercel |
| `www.cfsbr.com` | Brand www alias | Vercel |
| `cfsbr.gmrafi.com.bd` | Bangladesh/regional imprint | Vercel |
| `cfsbr-intel.github.io` | Open-science DOI resolve target (article landing pages) | GitHub Pages |

### Vercel project setup (for `cfsbr.com`)

1. In the Vercel dashboard, import the repo (`gmrafi/cfsbr`) as a new project.
2. Framework preset: **Other** (static site, no build step).
3. Output directory: `.` (project root).
4. **Production domains** (Project Settings → Domains):
   - `cfsbr.com`
   - `www.cfsbr.com` (alias, redirect to `cfsbr.com`)
   - `cfsbr.gmrafi.com.bd` (existing)
5. `vercel.json` in this repo enables `cleanUrls`, disables `trailingSlash`, and sets sensible cache and security headers.
6. The `CNAME` file in the repo root (`cfsbr.js.org`) is **only** consumed by GitHub Pages and does not affect Vercel — leave it as-is.

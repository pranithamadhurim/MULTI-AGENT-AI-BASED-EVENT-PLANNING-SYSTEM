# Multi-Agent AI-Based Event Planning System

> **College Final-Year / Capstone Project on Agentic AI**  
> Autonomous multi-agent coordination, real-time agent activity monitoring, and intelligent budget optimization powered by **LangGraph**, **Google Gemini**, **FastAPI**, **React**, and **SQLite**.

---

## 🌟 Project Overview

Event planning requires multi-disciplinary coordination across distinct domains: venue selection, culinary design, visual staging, entertainment production, vendor sourcing, and chronological timeline management—all strictly bounded by financial limits.

Traditional single-prompt LLM solutions fail at this complexity because they lack domain specialization, modular memory, and iterative negotiation.

This project implements a **collaborative multi-agent collective** where **10 specialized AI agents** communicate with a **Master Event Coordinator Agent**. Crucially, when an initial event plan exceeds the user's budget, an autonomous **Budget Optimization Feedback Loop** intervenes: it initiates inter-agent renegotiations, requests structured lower-cost alternatives, recalculates totals, and delivers an optimized plan with a transparent trade-off rationale.

---

## 🤖 The 10 AI Agents

| # | Agent Name | Architecture Role | Responsibilities & Structured Payload |
|---|------------|-------------------|---------------------------------------|
| **1** | **Master Event Coordinator Agent** | *Graph Orchestrator* | Initializes multi-agent blackboard, supervises graph transitions, synthesizes executive dossiers, and issues final sign-off. |
| **2** | **Event Requirement Agent** | *Specialist* | Deconstructs user inputs, extracts attendee profile, density ratio, risk flags, and logistical constraints. |
| **3** | **Budget Planning Agent** | *Specialist* | Establishes category baseline allocations (Venue 35%, Catering 30%, Decor 15%, Entertainment 12%, Vendors 8%, Contingency 5%). |
| **4** | **Venue Recommendation Agent** | *Specialist* | Matches capacity, location, and aesthetic needs; recommends 3 evaluated venues; selects primary venue and calculates rental cost. |
| **5** | **Catering Agent** | *Specialist* | Curates 4-course culinary menu (Appetizer, Main, Dessert, Beverages), manages dietary tags (Vegan, Halal, Gluten-Free), and computes per-guest cost. |
| **6** | **Decoration Agent** | *Specialist* | Formulates creative concept, color palette, staging, architectural lighting, and centerpieces with itemized costing. |
| **7** | **Entertainment Agent** | *Specialist* | Curates featured talent (Emcee/Host, Live Ensemble, DJ), AV hardware requirements, and sound/lighting cues. |
| **8** | **Vendor Agent** | *Specialist* | Sources verified local partners for Photography, Videography, Onsite Badging/Security with ratings and quotes. |
| **9** | **Schedule Agent** | *Synthesizer* | Merges inputs from all agents into a unified, chronological run-of-show itinerary with lead-agent attribution. |
| **10** | **Budget Optimization Agent** | *Feedback Negotiator* | Compares total cost vs budget cap. If over budget, issues renegotiation directives, calculates category savings, and produces an Optimization Report. |

---

## 🔄 Autonomous Budget Optimization Feedback Loop

```
[ User Request ] 
       │
       ▼
[ Master Coordinator ] ──> [ Requirement Agent ] ──> [ Budget Planning Agent ]
                                                               │
                                                               ▼
        ┌──────────────────────────────────────────────────────┴──────────────────────────────────────────────────────┐
        │                                                                                                             │
 [ Venue Agent ]          [ Catering Agent ]          [ Decor Agent ]          [ Entertainment Agent ]          [ Vendor Agent ]
        │                                                                                                             │
        └──────────────────────────────────────────────────────┬──────────────────────────────────────────────────────┘
                                                               │
                                                               ▼
                                                      [ Schedule Agent ]
                                                               │
                                                               ▼
                                                   [ Budget Evaluator Node ]
                                                               │
                                       ┌───────────────────────┴───────────────────────┐
                                       │                                               │
                           Total Cost > Budget?                             Total Cost <= Budget?
                                       │                                               │
                                 YES   ▼                                         NO    ▼
                        [ Budget Optimization Agent ]                         [ Master Finalize ]
                                       │                                               │
                                       ▼                                               ▼
                        [ Domain Renegotiation Node ]                                [ END ]
                                       │
                                       ▼
                         (Loops to Budget Evaluator)
```

1. **Initial Assessment**: The system calculates the aggregate cost across all 5 domain categories.
2. **Deficit Calculation**: If `Total Cost > Target Budget`, the conditional edge routes to `budget_optimization_agent`.
3. **Renegotiation Strategy**: The agent computes targeted reductions across categories (e.g. switching plated banquet to gourmet buffet, swapping single-use florals for architectural LED lighting, bundling media vendors).
4. **Re-evaluation**: The graph updates state with negotiated costs, recalculates net savings, and outputs a clear **Optimization Explanation**.

---

## 💻 Tech Stack

- **Frontend**: React 18, Vite, Tailwind CSS, Lucide Icons, Recharts (Donut & Bar charts).
- **Backend**: Python 3.11, FastAPI, Uvicorn, Pydantic v2.
- **Orchestration**: LangGraph StateGraph with conditional loop edges.
- **Database**: SQLite with SQLAlchemy async engine and aiosqlite.
- **AI Engine**: Google Gemini API (`gemini-2.5-flash`) with an embedded intelligent domain heuristic engine fallback for zero-crash demo reliability.
- **Document Export**: ReportLab PDF Generation engine.

---

## 🚀 How to Run the Application

### Option A: Quick Launch Scripts

1. **Start Backend**:
   ```powershell
   cd backend
   py -3.11 run.py
   ```
   *Runs FastAPI on `http://127.0.0.1:8000` with Swagger docs at `/docs`.*

2. **Start Frontend**:
   ```powershell
   cd frontend
   npm run dev
   ```
   *Runs React Vite UI on `http://localhost:5173`.*

### Option B: One-Click Startup Script (`start.bat`)
Run the provided `start.bat` script to launch both servers simultaneously in separate terminal windows.

---

## 🧪 College Viva / Demonstration Scenarios

### Test Scenario 1: Standard Balanced Event (Within Budget)
- **Preset**: Select **"Corporate Annual Summit"** (\$22,000 budget for 120 guests).
- **Behavior**: All 10 agents execute sequentially. Total cost stays within budget. The system produces the final dossier immediately.

### Test Scenario 2: Autonomous Budget Optimization Triggered
- **Preset**: Select **"Hackathon & Launch (Budget Constrained)"** (\$8,500 budget for 150 guests).
- **Behavior**: Aggregate costs initially exceed \$12,000. The **Budget Optimization Agent** activates, triggers the feedback loop, renegotiates with Venue, Catering, Decor, Entertainment, and Vendors, cuts over \$3,800 in costs, and displays the **Optimization Report** with before/after comparisons and trade-off explanations.

### Test Scenario 3: Interactive What-If Scenario Simulator
- Click **"What-If Simulator"** in the top bar.
- Drag the **Guests slider** from 150 to 350. Observe the real-time cost scaling on Catering and Venue capacity.
- Drag the **Budget slider** down to see instantaneous warning alerts and intelligent optimization advice.

### Test Scenario 4: PDF Export Dossier
- Click **"Export PDF Dossier"** on any active event plan to instantly download a formatted PDF proposal ready for printing.

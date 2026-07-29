# DairyFlow ERP

DairyFlow is a role-secured dairy operations system for BCU maintenance, tabela collections and expenses, employee attendance/payroll, home costs, loans, and reporting. Its backend is FastAPI and its cross-platform client is Flutter.

## Run locally

```bash
cd backend
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload
```

Run the mobile/desktop client from `frontend` with `flutter pub get` and `flutter run`; use `flutter run -d chrome` for web. The API documentation is at `http://localhost:8000/docs`.

Seeded credentials: `admin@dairyflow.com`, `BCU-001`, and `TAB-001`; each uses `password123`.

For a containerized PostgreSQL environment run `docker compose up --build`. Set a strong `JWT_SECRET` and terminate HTTPS at your ingress.

###############################################
# 1. BUILD FRONTEND (React)
###############################################
FROM node:18 AS frontend-builder

# Set work directory
WORKDIR /app/frontend

# Copy frontend package files
COPY frontend/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the frontend project
COPY frontend/ ./

# Build production-ready frontend
RUN npm run build



###############################################
# 2. BUILD BACKEND (Node/Express)
###############################################
FROM node:18 AS backend-builder

WORKDIR /app/backend

# Copy backend package files
COPY backend/package*.json ./

# Install backend dependencies
RUN npm install

# Copy backend source code
COPY backend/ ./



###############################################
# 3. FINAL IMAGE → Serve frontend + Run backend
###############################################
FROM node:18

WORKDIR /app

# Copy backend from stage 2
COPY --from=backend-builder /app/backend ./backend

# Copy frontend build into backend/public
RUN mkdir -p ./backend/public
COPY --from=frontend-builder /app/frontend/build ./backend/public

# Environment variables (overwrite in render/railway/docker compose)
ENV NODE_ENV=PRODUCTION
ENV PORT=5000

EXPOSE 5000

# Start backend server
CMD ["node", "backend/server.js"]

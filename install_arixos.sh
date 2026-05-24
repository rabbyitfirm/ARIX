#!/bin/bash

# ARIX Auto-Installer Script
# Developed by Rabby IT Firm
# Usage: curl -sSL https://raw.githubusercontent.com/rabbyitfirm/ARIX/main/scripts/install_arixos.sh | bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
function print_header() {
    clear
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}      ARIX Auto-Installer v1.0          ${NC}"
    echo -e "${BLUE}      Developed by Rabby IT Firm        ${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
}

function print_step() {
    echo -e "${YELLOW}➡️  $1${NC}"
}

function print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

function print_error() {
    echo -e "${RED}❌ $1${NC}"
    exit 1
}

function print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

function check_command() {
    if ! command -v $1 &> /dev/null; then
        print_warning "$1 is not installed. Attempting to install..."
        if [ "$1" = "docker" ]; then
            curl -fsSL https://get.docker.com | sh || print_error "Failed to install Docker."
        elif [ "$1" = "docker-compose" ]; then
            sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
            sudo chmod +x /usr/local/bin/docker-compose || print_error "Failed to install Docker Compose."
        elif [ "$1" = "git" ]; then
            sudo apt-get update && sudo apt-get install -y git || print_error "Failed to install Git."
        else
            print_error "$1 is required but could not be installed automatically."
        fi
    fi
}

function install_dependencies() {
    print_step "Installing dependencies..."

    # Check and install Git
    check_command "git"

    # Check and install Docker
    check_command "docker"

    # Check and install Docker Compose
    check_command "docker-compose"

    print_success "All dependencies installed."
}

function clone_repository() {
    print_step "Cloning ARIX repository..."
    if [ -d "ARIX" ]; then
        print_error "ARIX directory already exists. Please remove it first or run the update script."
    fi
    git clone https://github.com/rabbyitfirm/ARIX.git || print_error "Failed to clone repository."
    cd ARIX || print_error "Failed to enter ARIX directory."
    print_success "Repository cloned successfully."
}

function setup_environment() {
    print_step "Setting up environment..."

    if [ ! -f ".env" ]; then
        cp .env.example .env || print_error "Failed to create .env file."

        # Generate random secrets
        echo "Generating random secrets for .env file..."
        sed -i "s/POSTGRES_PASSWORD=.*/POSTGRES_PASSWORD=$(openssl rand -hex 16)/" .env
        sed -i "s/SECRET_KEY=.*/SECRET_KEY=$(openssl rand -hex 32)/" .env
        sed -i "s/OPENAI_API_KEY=.*/OPENAI_API_KEY=your_openai_key_here/" .env
        sed -i "s/GITHUB_ID=.*/GITHUB_ID=your_github_client_id/" .env
        sed -i "s/GITHUB_SECRET=.*/GITHUB_SECRET=your_github_client_secret/" .env

        print_warning "Please edit the .env file to add your actual API keys:"
        print_warning "  - OPENAI_API_KEY (Get it from https://platform.openai.com/account/api-keys)"
        print_warning "  - GITHUB_ID and GITHUB_SECRET (Create a GitHub OAuth app at https://github.com/settings/developers)"
    fi

    print_success "Environment file configured."
}

function start_services() {
    print_step "Starting ARIX services..."

    # Build images
    print_step "Building Docker images..."
    docker-compose -f infra/docker/docker-compose.yml build || print_error "Failed to build Docker images."

    # Start containers
    print_step "Starting containers..."
    docker-compose -f infra/docker/docker-compose.yml up -d || print_error "Failed to start containers."

    print_success "Services started successfully."
}

function verify_installation() {
    print_step "Verifying installation..."

    # Wait for services to start
    print_step "Waiting for services to initialize (this may take 1-2 minutes)..."
    sleep 60

    # Check frontend
    if curl -s http://localhost:3000 > /dev/null; then
        print_success "Frontend is running at http://localhost:3000"
    else
        print_error "Frontend is not running. Check logs with: docker-compose -f infra/docker/docker-compose.yml logs frontend"
    fi

    # Check backend
    if curl -s http://localhost:8000/health > /dev/null; then
        print_success "Backend is running at http://localhost:8000"
    else
        print_error "Backend is not running. Check logs with: docker-compose -f infra/docker/docker-compose.yml logs backend"
    fi

    # Check database
    if docker-compose -f infra/docker/docker-compose.yml exec db pg_isready -U postgres > /dev/null; then
        print_success "Database is running"
    else
        print_error "Database is not running. Check logs with: docker-compose -f infra/docker/docker-compose.yml logs db"
    fi
}

function display_info() {
    print_header
    echo -e "${GREEN}ARIX has been successfully installed!${NC}"
    echo ""
    echo -e "${YELLOW}🌐 Access Points:${NC}"
    echo "  - Frontend:       http://localhost:3000"
    echo "  - Backend:       http://localhost:8000"
    echo "  - API Docs:       http://localhost:8000/docs"
    echo "  - Database:      PostgreSQL at localhost:5432"
    echo "  - Vector DB:      Qdrant at localhost:6333"
    echo "  - Cache:          Redis at localhost:6379"
    echo ""
    echo -e "${YELLOW}🛠️  Management Commands:${NC}"
    echo "  - Stop ARIX:       docker-compose -f infra/docker/docker-compose.yml down"
    echo "  - Restart:        docker-compose -f infra/docker/docker-compose.yml restart"
    echo "  - View logs:      docker-compose -f infra/docker/docker-compose.yml logs -f"
    echo "  - Update:         git pull origin main && docker-compose -f infra/docker/docker-compose.yml up -d --build"
    echo ""
    echo -e "${YELLOW}📝 Next Steps:${NC}"
    echo "  1. Edit the .env file to add your API keys"
    echo "  2. Access the frontend at http://localhost:3000"
    echo "  3. Create your first workflow in the A to Z Builder"
    echo "  4. Explore the Agent Dashboard"
    echo "  5. Check out the documentation at https://github.com/rabbyitfirm/ARIX/wiki"
    echo ""
    echo -e "${YELLOW}📞 Need Help?${NC}"
    echo "  - Open an issue: https://github.com/rabbyitfirm/ARIX/issues"
    echo "  - Contact support: support@rabbyitfirm.com"
    echo ""
}

function cleanup() {
    print_step "Cleaning up old installations..."
    docker-compose -f infra/docker/docker-compose.yml down 2>/dev/null
    print_success "Cleanup complete."
}

# Main execution
print_header

# Check if already installed
if [ -d "ARIX" ]; then
    echo -e "${YELLOW}ARIX directory already exists.${NC}"
    read -p "Do you want to update ARIX? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cd ARIX || print_error "Failed to enter ARIX directory."
        git pull origin main || print_error "Failed to update repository."
        cleanup
        start_services
        verify_installation
        display_info
        exit 0
    else
        print_error "Installation aborted."
    fi
fi

# Install ARIX
install_dependencies
clone_repository
setup_environment
cleanup
start_services
verify_installation
display_info
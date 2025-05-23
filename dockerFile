FROM python:3.11-slim

# Install required system packages
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir \
    setuptools \
    robotframework \
    robotframework-seleniumlibrary \
    robotframework-requests \
    robotframework-faker \
    Faker

# Set working directory
WORKDIR /robot-tests

# Copy test files and project into the container
COPY . .

# Run only the API tests
CMD ["robot", "--outputdir", "results", "tests/api"]
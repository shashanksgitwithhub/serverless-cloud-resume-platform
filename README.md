# ☁️Serverless Cloud Resume Platform

A production-style **serverless cloud resume platform** built on AWS as part of the Cloud Resume Challenge.

The project takes a personal resume website and turns it into a complete cloud-hosted application with a globally distributed frontend, custom DNS, HTTPS, a serverless backend, persistent visitor data, IAM-based access control, monitoring, and automated CI/CD deployment.

---

## Project Overview

The goal of this project was to design and deploy my personal resume website using AWS cloud services instead of traditional web hosting.

The completed platform consists of:

* A static resume website
* Global content delivery through CloudFront
* Custom domain and DNS through Route 53
* HTTPS-secured website access
* A serverless visitor counter
* API Gateway for backend communication
* Lambda for backend processing
* DynamoDB for persistent visitor data
* IAM roles and policies for controlled AWS access
* CloudWatch for Lambda logging
* GitHub Actions for CI/CD automation

The project demonstrates how multiple managed AWS services can be combined to build a complete application without maintaining traditional servers.

---

# Architecture

```text
                         USERS
                           |
                           v
                    +-------------+
                    |  Route 53   |
                    |     DNS     |
                    +------+------+
                           |
                           v
                    +-------------+
                    | CloudFront  |
                    |     CDN     |
                    +------+------+
                           |
                           v
                    +-------------+
                    |     S3      |
                    |  Frontend   |
                    +-------------+
                           |
                           | JavaScript API Request
                           v
                    +-------------+
                    | API Gateway |
                    |     API     |
                    +------+------+
                           |
                           v
                    +-------------+
                    |   Lambda    |
                    |   Backend   |
                    +------+------+
                           |
                           v
                    +-------------+
                    |  DynamoDB   |
                    |   Counter   |
                    +-------------+

                           |
                           v
                    +-------------+
                    | CloudWatch  |
                    |    Logs     |
                    +-------------+

                      IAM
                       |
                       v
                Access Control


                DEVELOPMENT / CI-CD

                  GitHub Repository
                         |
                         v
                  GitHub Actions
                         |
                         v
                    AWS Deployment
```

---

# What I Built

I built a personal resume website and deployed it as a **serverless cloud application**.

The frontend is hosted on Amazon S3 and delivered globally through CloudFront. Route 53 manages the custom domain, while HTTPS provides secure access.

I also extended the static website with a dynamic visitor counter. The frontend communicates with an API Gateway endpoint, which invokes Lambda. Lambda interacts with DynamoDB to retrieve and maintain the visitor count.

The complete application therefore combines both **static content delivery and serverless backend functionality**.

---

# AWS Services Used

| Service               | What I Implemented                              |
| --------------------- | ----------------------------------------------- |
| **Amazon S3**         | Hosted the static resume website files          |
| **Amazon CloudFront** | Distributed and cached website content globally |
| **Amazon Route 53**   | Configured custom domain DNS                    |
| **API Gateway**       | Exposed the visitor counter backend as an API   |
| **AWS Lambda**        | Implemented the serverless backend logic        |
| **Amazon DynamoDB**   | Stored the visitor counter data                 |
| **AWS IAM**           | Controlled Lambda and AWS resource permissions  |
| **Amazon CloudWatch** | Captured and inspected Lambda execution logs    |
| **GitHub Actions**    | Automated deployment through CI/CD              |

---

# 1. Frontend

The frontend was developed using:

* HTML
* CSS
* JavaScript

The website contains my personal resume information and acts as the user-facing layer of the application.

The frontend is responsible for:

* Displaying resume content
* Providing navigation between sections
* Loading static assets
* Calling the backend visitor counter API
* Displaying the visitor count returned by the backend

The website is designed as a static application, which makes Amazon S3 and CloudFront suitable for hosting and distribution.

---

# 2. Amazon S3 — Website Hosting

Amazon S3 is used as the storage layer for the website.

The static website files are stored in an S3 bucket, including:

```text
index.html
CSS files
JavaScript files
Images / assets
```

S3 provides the durable storage required for the frontend without requiring an application server.

The frontend architecture is therefore:

```text
Website Files
     |
     v
Amazon S3
     |
     v
CloudFront
     |
     v
Users
```

---

# 3. Amazon CloudFront — Content Delivery

CloudFront was implemented as the CDN layer in front of the website.

It provides:

* Global content distribution
* Edge caching
* Faster delivery of static assets
* HTTPS support
* Integration with the custom domain

Instead of users accessing the S3 origin directly, the production website is delivered through CloudFront.

```text
User
 |
 v
CloudFront
 |
 v
S3
```

This provides a more production-oriented architecture than exposing the storage layer directly to users.

---

# 4. Route 53 — Custom DNS

Amazon Route 53 was used to connect my custom domain with the CloudFront distribution.

The DNS flow is:

```text
Custom Domain
      |
      v
Route 53
      |
      v
CloudFront
      |
      v
S3
```

This allows users to access the application using my own domain instead of an AWS-generated service URL.

---

# 5. HTTPS

HTTPS was configured for secure communication with the website.

The final access pattern is:

```text
https://my-domain
```

rather than serving the production website over plain HTTP.

This provides encrypted communication between the user's browser and the website.

---

# 6. Serverless Backend

The static website was extended with a dynamic backend using AWS serverless services.

The backend consists of:

```text
API Gateway
      |
      v
Lambda
      |
      v
DynamoDB
```

This allows the application to process visitor data without running or maintaining an EC2 server.

---

# 7. API Gateway — Backend API

Amazon API Gateway provides the HTTP endpoint used by the frontend.

The website JavaScript sends a request to the API:

```text
Browser
   |
   | HTTP Request
   v
API Gateway
```

API Gateway then invokes the Lambda function.

This creates a clean separation between:

```text
Frontend
    |
    v
API Layer
    |
    v
Backend Logic
    |
    v
Database
```

---

# 8. AWS Lambda — Backend Logic

AWS Lambda contains the backend logic for the visitor counter.

Lambda is responsible for:

* Receiving the API request
* Processing the visitor counter operation
* Communicating with DynamoDB
* Returning the result to API Gateway

The Lambda function runs only when invoked, eliminating the need for a continuously running server.

```text
API Gateway
      |
      v
Lambda
      |
      v
DynamoDB
```

This demonstrates the use of **serverless compute** in a real application.

---

# 9. DynamoDB — Visitor Counter

Amazon DynamoDB is used to persist the visitor counter.

The application uses DynamoDB to maintain visitor information that must survive beyond an individual Lambda execution.

The logical flow is:

```text
Website
   |
   v
API Gateway
   |
   v
Lambda
   |
   v
DynamoDB
   |
   v
Visitor Count
```

The visitor count can then be returned to the frontend and displayed on the resume website.

This added a dynamic component to an otherwise static website.

---

# 10. CORS Configuration

Because the frontend and API are separate origins, CORS was configured to allow the website to communicate with the API from the browser.

The communication is:

```text
Resume Website
      |
      | Cross-Origin Request
      v
API Gateway
```

CORS configuration allows the browser to accept the API response from the approved frontend origin.

This was necessary for the JavaScript frontend to successfully call the backend API.

---

# 11. IAM — Security and Permissions

AWS IAM was used to control permissions between AWS services.

The Lambda function uses an IAM execution role.

The role provides:

* Basic Lambda execution permissions
* CloudWatch logging permissions
* Required DynamoDB access

The project follows the principle of **least privilege**, avoiding unnecessary permissions wherever possible.

The security model is:

```text
Lambda
  |
  v
IAM Role
  |
  +---- CloudWatch Logs
  |
  +---- DynamoDB
```

AWS credentials were not embedded inside the website source code.

---

# 12. CloudWatch — Monitoring and Logging

Amazon CloudWatch was used to monitor Lambda execution through logs.

CloudWatch provides visibility into:

* Lambda executions
* Application output
* Errors
* Backend troubleshooting

The logging architecture is:

```text
Lambda
   |
   v
CloudWatch Logs
```

This made it possible to investigate backend failures and verify that Lambda executions were occurring correctly.

---

# 13. Git and GitHub

Git was used for local version control throughout the project.

The repository contains the project source code and documentation.

Git was used to create checkpoints as meaningful parts of the project were completed.

Example:

```bash
git add .
git commit -m "Add serverless visitor counter"
```

Each commit represents a checkpoint in the development history.

The repository was then pushed to GitHub.

```text
Local Project
     |
     v
Git
     |
     v
GitHub Repository
```

---

# 14. GitHub Actions — CI/CD

GitHub Actions was implemented to automate deployment.

The development workflow is:

```text
Code Change
    |
    v
Git Commit
    |
    v
Git Push
    |
    v
GitHub
    |
    v
GitHub Actions
    |
    v
Automated Deployment
    |
    v
AWS
```

This removes repetitive manual deployment steps and demonstrates practical CI/CD implementation.

---

# 15. Complete Application Flow

When a user visits the resume website:

```text
1. User requests the custom domain
              |
              v
2. Route 53 resolves the domain
              |
              v
3. CloudFront receives the request
              |
              v
4. CloudFront serves the frontend
              |
              v
5. JavaScript loads
              |
              v
6. JavaScript calls API Gateway
              |
              v
7. API Gateway invokes Lambda
              |
              v
8. Lambda accesses DynamoDB
              |
              v
9. Visitor count is returned
              |
              v
10. API Gateway returns the response
              |
              v
11. Website displays the visitor count
```

---

# 16. Cloud Architecture Characteristics

The completed architecture provides:

### Serverless

No traditional application server is required for the backend.

### Scalable

CloudFront, API Gateway, Lambda, and DynamoDB are managed AWS services designed to scale without manually managing servers.

### Highly Available

The application relies primarily on managed AWS services rather than a single manually maintained server.

### Secure

IAM permissions, HTTPS, CORS, and controlled service access were implemented.

### Observable

Lambda execution logs are available through CloudWatch.

### Automated

GitHub Actions provides automated deployment.

---

# 17. Problems Solved

During development, the project required solving several practical cloud engineering problems, including:

* Connecting a static frontend to a serverless backend
* Configuring DNS for a custom domain
* Serving the website securely through HTTPS
* Connecting API Gateway to Lambda
* Connecting Lambda to DynamoDB
* Configuring CORS for browser-based API requests
* Assigning the correct IAM permissions
* Troubleshooting Lambda execution through CloudWatch
* Managing the project with Git
* Automating deployment through GitHub Actions

These were implemented as part of the actual project rather than only being studied theoretically.

---

# 18. Testing and Validation

The completed system was validated across the major components.

### Website

* Resume loads successfully
* Static assets load correctly
* Custom domain resolves correctly
* HTTPS works correctly

### CloudFront

* Distribution successfully serves the website
* Static content is delivered through the CDN

### API

* API Gateway endpoint responds correctly
* Frontend successfully communicates with the API

### Lambda

* Function executes successfully
* DynamoDB operations complete successfully
* Logs appear in CloudWatch

### DynamoDB

* Visitor counter data persists correctly
* Lambda can access the required table

### CORS

* Browser requests from the website are accepted by the API

### CI/CD

* Changes pushed to GitHub trigger the deployment workflow

---

# 19. Key Skills Demonstrated

### Cloud

* AWS Architecture
* Serverless Architecture
* Cloud Deployment
* AWS Service Integration

### AWS Services

* Amazon S3
* Amazon CloudFront
* Amazon Route 53
* Amazon API Gateway
* AWS Lambda
* Amazon DynamoDB
* AWS IAM
* Amazon CloudWatch

### Networking

* DNS
* HTTPS
* CDN
* API endpoints
* CORS

### DevOps

* Git
* GitHub
* GitHub Actions
* CI/CD
* Deployment Automation

### Security

* IAM Roles
* IAM Policies
* Least-Privilege Access
* HTTPS
* Secure Credential Management

---

# 20. Technologies Used

```text
Frontend:
HTML
CSS
JavaScript

Cloud:
AWS

AWS Services:
S3
CloudFront
Route 53
API Gateway
Lambda
DynamoDB
IAM
CloudWatch

DevOps:
Git
GitHub
GitHub Actions
CI/CD

Networking:
DNS
HTTPS
CORS
REST API
```

---

# 21. Final Result

The completed project transformed a personal resume into a **fully deployed serverless cloud application**.

```text
                    CLOUD RESUME PLATFORM

                         Custom Domain
                              |
                              v
                         Route 53
                              |
                              v
                         CloudFront
                              |
                              v
                             S3
                              |
                         Frontend
                              |
                         JavaScript
                              |
                              v
                         API Gateway
                              |
                              v
                           Lambda
                              |
                              v
                         DynamoDB

                    Supporting Services
                              |
              +---------------+---------------+
              |                               |
             IAM                         CloudWatch
              |
              v
        Access Control

                    Development / Delivery
                              |
                           GitHub
                              |
                       GitHub Actions
                              |
                              v
                            AWS
```

---

# 22. Project Outcome

This project gave me practical experience in designing and deploying a complete AWS application rather than working with individual AWS services in isolation.

The final architecture demonstrates the integration of:

**S3 + CloudFront + Route 53 + API Gateway + Lambda + DynamoDB + IAM + CloudWatch + GitHub Actions**

The project strengthened my understanding of:

* Cloud architecture
* Serverless computing
* AWS networking
* API development
* NoSQL databases
* IAM security
* Cloud monitoring
* Git-based development
* CI/CD automation

---

## Author

**Shashank TJ**

Cloud Computing | AWS | DevOps | Linux | Python

GitHub: [Add GitHub Profile]

Portfolio: [Add Portfolio URL]

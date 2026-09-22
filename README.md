<a href="https://git.io/typing-svg"><img src="https://readme-typing-svg.demolab.com?font=Avenir+Next+LT+Pro&weight=100&size=55&duration=5021&pause=1000&vCenter=true&repeat=false&width=1200&height=100&lines=%E2%98%81%EF%B8%8FServerless+Cloud+Resume+Platform" alt="Typing SVG" /></a>


### A production-style **serverless cloud resume platform** built on AWS as part of the Cloud Resume Challenge. ###

<div align="left">
  <h1>Project - (https://shashanktj.com)</h1>
</div>


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

<img width="522" height="1242" alt="CLOUD_RS drawio" src="https://github.com/user-attachments/assets/ce8180c2-cef3-4e46-b004-d57a9cd09337" />

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

<img width="182" height="422" alt="Frontend drawio" src="https://github.com/user-attachments/assets/861859b5-46a8-4e65-b64f-ebd25d9df8a3" />

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

<img width="182" height="322" alt="CR drawio" src="https://github.com/user-attachments/assets/a4f7a9f4-d8b3-4d4b-bc59-fac8991eb955" />

This provides a more production-oriented architecture than exposing the storage layer directly to users.

---

# 4. Route 53 — Custom DNS

Amazon Route 53 was used to connect my custom domain with the CloudFront distribution.

The DNS flow is:

<img width="212" height="422" alt="F1 drawio" src="https://github.com/user-attachments/assets/07f3cd7c-7a4c-4fcc-aee4-91446ddba3c5" />

This allows users to access the application using my own domain instead of an AWS-generated service URL.

---

# 5. HTTPS

HTTPS was configured for secure communication with the website.

The final access pattern is:

```text
https://shashanktj.com
```

rather than serving the production website over plain HTTP.

This provides encrypted communication between the user's browser and the website.

---

# 6. Serverless Backend

The static website was extended with a dynamic backend using AWS serverless services.

The backend consists of:

<img width="212" height="322" alt="f2 drawio" src="https://github.com/user-attachments/assets/4e2f1e38-33ed-4851-9667-b1018b461a7d" />

This allows the application to process visitor data without running or maintaining an EC2 server.

---

# 7. API Gateway — Backend API

Amazon API Gateway provides the HTTP endpoint used by the frontend.

The website JavaScript sends a request to the API:

<img width="212" height="252" alt="f3 drawio" src="https://github.com/user-attachments/assets/b94e01d4-1ae2-4a6a-93f0-ed940787a92c" />

API Gateway then invokes the Lambda function.

This creates a clean separation between:

<img width="212" height="452" alt="f4 drawio" src="https://github.com/user-attachments/assets/ff858ea7-5e0f-4eae-bc2e-96c4f7425b13" />

---

# 8. AWS Lambda — Backend Logic

AWS Lambda contains the backend logic for the visitor counter.

Lambda is responsible for:

* Receiving the API request
* Processing the visitor counter operation
* Communicating with DynamoDB
* Returning the result to API Gateway

The Lambda function runs only when invoked, eliminating the need for a continuously running server.

<img width="212" height="342" alt="f5 drawio" src="https://github.com/user-attachments/assets/a3f8f9de-01d0-4cff-ac8f-36e624ef360b" />

This demonstrates the use of **serverless compute** in a real application.

---

# 9. DynamoDB — Visitor Counter

Amazon DynamoDB is used to persist the visitor counter.

The application uses DynamoDB to maintain visitor information that must survive beyond an individual Lambda execution.

The logical flow is:

<img width="212" height="562" alt="f6 drawio" src="https://github.com/user-attachments/assets/2009ed35-a51b-4072-b4c2-b1dca5079556" />

The visitor count can then be returned to the frontend and displayed on the resume website.

This added a dynamic component to an otherwise static website.

---

# 10. CORS Configuration

Because the frontend and API are separate origins, CORS was configured to allow the website to communicate with the API from the browser.

The communication is:

<img width="272" height="282" alt="f7 drawio" src="https://github.com/user-attachments/assets/582c9c88-de6c-49b8-a192-90d2cd39410a" />

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

<img width="322" height="332" alt="f8 drawio" src="https://github.com/user-attachments/assets/10d06fac-a3ed-4935-89db-5fa0cc2cbc8e" />

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

<img width="212" height="240" alt="f9 drawio" src="https://github.com/user-attachments/assets/f8b6de25-dc27-44f9-a4da-266270882cfc" />


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

<img width="212" height="350" alt="f1 drawio" src="https://github.com/user-attachments/assets/2740a601-d0fd-49a2-8ef0-3ec40e10dd14" />

---

# 14. GitHub Actions — CI/CD

GitHub Actions was implemented to automate deployment.

The development workflow is:

<img width="292" height="790" alt="f5 drawio" src="https://github.com/user-attachments/assets/51aa7628-3dad-4328-ad79-991ce2876eef" />

This removes repetitive manual deployment steps and demonstrates practical CI/CD implementation.

---

# 15. Complete Application Flow

When a user visits the resume website:

<img width="452" height="1230" alt="f4 drawio" src="https://github.com/user-attachments/assets/4fc832bb-0559-431c-8b95-d936fa0c6e43" />

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

<img width="582" height="1770" alt="Final drawio" src="https://github.com/user-attachments/assets/11c2fc9a-4a33-46a7-a95b-e7554ba25720" />

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

GitHub: https://github.com/shashanksgitwithhub

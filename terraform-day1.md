### Need for Infrastructure Provisioning


* In CI/CD pipelines, we need to create various test environments according to organizational QA policy.

* To create test environments, we might also need to create virtual infrastructure on the cloud / Hypervisor (VMWare, Hyper-V).

* To automate this infrastructure creation/updation we need some kind of a tool and these tools are called as Infra Provisioning Tools

* Depending on the infrastructure used in the organization we will have different tools which can help us in automating infrastructure creation

![Preview](./Images/terraform1.png)

* To solve this problem an organization called as Hashicorp has came up with a tool called as Terraform which can work with multiple infra providers

![Preview](./Images/terraform2.png)

* Procedural vs Declarative

![Preview](./Images/terraform3.png)

* Using Terraform we would use declarative approach to specify what are our infrastructure needs => Infrastructure as Code (IaC)

* Workflow: 

![Preview](./Images/terraform4.png)

* Terraform is Cloud-agnostic because deploy to any cloud or virtual infra provider

![Preview](./Images/terraform5.png)

* Terraform integrates with different clouds through Terrraform providers

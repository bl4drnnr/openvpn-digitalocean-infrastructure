<h1 align="center">
    OpenVPN DigitalOcean Terraform infrastructure
</h1>

## Table of contents
1. [Introduction](#introduction)
2. [Theory](#theory)
3. [Network Diagram and Description](#network-diagram-and-description)
4. [Step-by-Step Guideline](#step-by-step-guideline)
5. [Repository Source Code Usage](#repository-source-code-usage)
6. [References and Contact](#references-and-contact)
7. [License](#license)

![DigitalOcean](https://img.shields.io/badge/DigitalOcean-%230167ff.svg?style=for-the-badge&logo=digitalOcean&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)

---

### Introduction

**OpenVPN** - is a virtual private network system that implements techniques to create secure point-to-point or site-to-site connections in routed or bridged configurations and remote access facilities. It implements both client and server applications.

**DigitalOcean** - is an American cloud infrastructure provider. DigitalOcean provides developers, startups, and SMBs with cloud **infrastructure-as-a-service** (or just **IaaS**) platforms.

**Terraform** - is an open-source, infrastructure as code, software tool created by HashiCorp. Users define and provide data center infrastructure using a declarative configuration language known as HashiCorp Configuration Language, or optionally JSON.

The presented project presents **OpenVPN** infrastructure build on **DigitalOcean** with help of **Terraform** IaaS programming language. Bellow will be described:

- the diagram of the whole built virtual privagte network with devices
- step-by-step instruction on how to implement it using **Terraform** (this repository) and on your own
- detailed information about **TLS/SSL, HTTPS, certificates, key pairs** etc.

_**Happy reading!**_

---

### Theory

Let's start with a little bit of theory.

First of all, we shoud define terminology we are going to use.
1. **Client** - end-user, you or your laptop, mobile phone etc.
2. **OpenVPN Server** (or just **server**) - server, where we configured our OpenVPN service. Also, this is server we, as clients, are going to connect.
3. **Certificate Authorities** (or just **CA**) - is an entity that stores, signs, and issues digital certificates. In our particular case, it is only going to sign requests by server.
4. **Certificate** - in cryptography, a public key certificate, also known as a digital certificate or identity certificate, is an electronic document used to prove the validity of a public key.

One very important thing to mention:
- Only our **OpenVPN Server** will be the only one entity, that will generate private keys and certificates for **clients**.

When client wants to connect to server, it has to show certificate, sign by CA. But how does this signing work? As it has been mentioned above, only our server is entity, that can generate those certificates for clients

1. Server generates request (**certificate request**) and private key.
2. Certificate request is sent to CA server, where it is signed and sent back.
3. Then, _**using certificate of CA, user certificate and key**_, server will generate configuration file for client. It it a file, client is going to use in order to connect to VPN server. Every client must have its own config and each must align with the settings outlined in the server’s configuration file

So, let's break this down step-by-step, how clients connect to VPN servers:

1. Client wants to connect to server. In order to do that, it shows to server its certificate.
2. Certificate contains public key and sign by **CA**.
3. Server checks, if certificate is signed by proper **CA**. How can it do that? The certificate of **CA** is stored on server.

---

### Network Diagram and Description

---

### Step-by-step guideline

---

### Repository Source Code Usage

In case if you want to clone this repository and create your own OpenVPN DigitalOcean infrastructure, here is how you can do this.
Just follow next easy steps:

1. Clone this repository locally on your machine
    ```
    git clone https://github.com/bl4drnnr/openvpn-digitalocean-infrastructure.git
    ```
2. In root folder of the project create file with name `terraform.tfvars`. The name can be whatever you want it to be, but it has to end with `.tfvars`.
3. In this file put next string - `do_token = "<YOUR_DIGITALOCEAN_API_TOKEN>"`. If you don't know where to find it, see [here](https://docs.digitalocean.com/reference/api/create-personal-access-token/). **Make sure generated token has write permissions!**
4. Open up your terminal and navigate to folder with project.
5. Type `terraform plan` and then `terraform apply`. In case if you have changed the name of file with variables you need to specify it by using `-var-file` flag, so, your commands will be looking like this:
    ```
    terraform plan -var-file="<NAME_OF_VARS_FILE>"
    terraform apply -var-file="<NAME_OF_VARS_FILE>"
    ```
    The same situation if you want to destroy built infrastructure:
    ```
    terraform destroy
    terraform destroy -var-file="<NAME_OF_VARS_FILE>"
    ```

---

### References and Contact

- Developer contact - [mikhail.bahdashych@protonmail.com](mailto:mikhail.bahdashych@protonmail.com)
- Terraform official page - [link](https://www.terraform.io/)
- DigitalOcean official page - [link](https://www.digitalocean.com/)
- OpenVPN official page - [link](https://openvpn.net/)
- Terraform documentation - [link](https://developer.hashicorp.com/terraform)
- Terraform with DigitalOcean provider documentation - [link](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs)
- DigitalOcean generation API tokens - [link](https://docs.digitalocean.com/reference/api/create-personal-access-token/)
- Official guideline by DigitalOcean - [link](https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-an-openvpn-server-on-ubuntu-20-04)

---

### License

Licensed by [MIT LICENSE](LICENSE).

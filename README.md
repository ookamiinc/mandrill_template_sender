# mandrill_template_sender
Mandrill Template Sender allows you to send template easily from one mandrill account to another mandrill acount.

# How this works

Use Mandrill API
https://mandrillapp.com/api/docs/templates.JSON.html

## Check if template exists

Use /templates/list.json  
Go to 1 if it doesnot exist  
Go to 2 if it exists

### 1. Create New template

- Get Information /templates/info.json
- Add new template /templates/add.json in production

### 2. Update existing template

- Get Information /templates/info.json
- Update existing template /templates/update.json in production

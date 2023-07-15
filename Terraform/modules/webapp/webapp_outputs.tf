output "web_app_url" {
  description = "URL of the deployed Web App."
  value       = azurerm_linux_web_app.example.default_hostname
}
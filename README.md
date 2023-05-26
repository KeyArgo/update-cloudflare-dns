# update-cloudflare-dns

This repository contains a script for automatically updating a Cloudflare DNS A record to point to a dynamic DNS (DDNS) service instead of a static IP address. This can be useful if your IP address changes frequently.

## Prerequisites

- A domain name managed by Cloudflare
- A Cloudflare account
- Cloudflare API key
- A dynamic DNS (DDNS) service
- A server running a Unix-like operating system (like Linux or macOS)
- Basic knowledge of the command line

## How to use

1. Download the `cloudflare_ddns.sh` script.

2. Open the script in a text editor and replace the placeholders at the top with your actual information:
```bash 
auth_email="your_cloudflare_account_email"
auth_key="your_cloudflare_api_key"
zone_identifier="your_cloudflare_zone_id"
record_name="your_domain_or_subdomain"
```

3. Make the script executable by running this command in the terminal: 
```bash chmod +x cloudflare_ddns.sh```
5. Test the script by running it manually:
```bash ./cloudflare_ddns.sh```
7. If the script works as expected, you can set it up to run automatically at regular intervals using cron. To do this, type `crontab -e` in your terminal to open the crontab configuration file. Add a line like this to schedule the script to run every hour:
```bash 0 * * * * /path/to/cloudflare_ddns.sh```


Save and exit the crontab file. The cron daemon will now automatically run your script according to the schedule you specified.

## Troubleshooting

If you run into problems, check the following:

- Make sure you replaced all the placeholders in the script with your actual information.
- Check the permissions of the script. It needs to be executable to be run as a script.
- If the script isn't running as expected from cron, check your system's mail or the syslog for error messages.

## License

This script is released under the MIT License. See the included LICENSE file for more details.




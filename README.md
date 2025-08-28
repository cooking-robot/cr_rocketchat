# Rocket.Chat

Install and configure Rocket.Chat client.

This project is a part of Cooking Robot group.

## Rocket.Chat Desktop

Use the recipe `cr_rocketchat::desktop` to install Rocket Chat Desktop.

### attributes

- `default['rocketchat']['server']['url']`: URL for your Rocket Chat server
- `default['rocketchat']['server']['name']`: Name of your instance
- `default['rocketchat']['version']`: Version of Rocket.Chat to install
- `default['rocketchat']['disable_updates']`: (enable by default) disable automatic update notifications

I recommand to disable automatic update notification to keep the full control of version in use by users.

The recipe install Rocket.Chat Desktop as "all users". The best practice is not giving admin rights to users. If users are not privileged, they can't run the upgrade themself. So the upgrade notification make no sense.

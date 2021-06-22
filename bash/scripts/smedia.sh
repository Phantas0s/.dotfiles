#!/usr/bin/sudo /bin/bash

# Block social media for you to focus on more important tasks.
# You can put this script in your PATH (/usr/bin/smedia for example). Don't forget to change the permissions (sudo chmod 755 /usr/bin/smedia)

# To block ALL social media: sudo smedia block
# To block only TWITTER: sudo smedia twitter
# To unblock ALL: sudo smedia unblock

# Add here the social media you're addicted to:
twitter=(
    tweetdeck.twitter.com
    twitter.com
    www.twitter.com
    api.twitter.com
)

social_media=(
    "${twitter[@]}"
    facebook.com
    www.facebook.com
    indiehackers.com
    www.indiehackers.com
    linkedin.com
    www.linkedin.com
    reddit.com
    www.reddit.com
    api.reddit.com
    dev.to
    www.dev.to
    recurse.zulipchat.com
    flurly.com
    api.flurly.com
)


if [[ ! -f /etc/hosts ]]; then
    echo "You don't have the file /etc/hosts. Are you worried?"
    exit 0
fi

if [[ ! -w /etc/hosts ]]; then
    echo "You can't write the file /etc/hosts. Try with sudo?"
    exit 0
fi

localhost=127.0.0.1

if [[ $1 == "block" ]]; then
    for i in "${social_media[@]}"; do
        sed -i "/^$localhost $i/d" /etc/hosts
        echo "$localhost $i" >> /etc/hosts;
    done
elif [[ $1 == "twitter" ]]; then
    for i in "${twitter[@]}"; do
        sed -i "/^$localhost $i/d" /etc/hosts
        echo "$localhost $i" >> /etc/hosts;
    done
elif [[ $1 == "unblock" ]]; then
    for i in "${social_media[@]}"; do
        sed -i "/^$localhost $i/d" /etc/hosts
    done
else
    echo "Please run this script with 'block' (block all), 'twitter' (block twitter), or 'unblock' as argument and feel the intense productivity!"
fi



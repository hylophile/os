ARG FEDORA_VERSION=39

FROM quay.io/fedora-ostree-desktops/sericea:$FEDORA_VERSION

# COPY usr /usr

COPY --from=ghcr.io/babashka/babashka:latest /usr/local/bin/bb /usr/bin/bb
COPY --from=ghcr.io/charmbracelet/gum:latest /usr/local/bin/gum /usr/bin/gum
COPY --from=ghcr.io/hylophile/eww:latest /eww /usr/bin/eww

RUN rpm-ostree override remove firefox firefox-langpacks toolbox && \
    rpm-ostree install bat direnv keychain fish distrobox && \

    # Enable automatic update staging
    sed -i 's/#AutomaticUpdatePolicy.*/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf && \
    systemctl enable rpm-ostreed-automatic.timer && \
    rpm-ostree cleanup -m && \

    # Build the image
    ostree container commit

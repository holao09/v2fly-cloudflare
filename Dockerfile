FROM v2fly/v2fly-core:latest
LABEL maintainer "Việt Nguyễn mrholao09@gmail.com>"
RUN apk add --no-cache --update wireguard-tools wget
RUN modprobe wireguard
RUN wget https://github.com/ViRb3/wgcf/releases/download/v2.2.12/wgcf_2.2.12_linux_amd64 && \
    chmod +x wgcf_2.2.12_linux_amd64 && \
    ./wgcf_2.2.12_linux_amd64 register --accept-tos --config wgcf-account.toml && \
    ./wgcf_2.2.12_linux_amd64 generate --profile wgcf-profile.conf && \
    mv wgcf-profile.conf /etc/wireguard/wg0.conf

CMD [ "/usr/bin/v2ray", "-config", "/etc/v2ray/config.json" ]
ENTRYPOINT [ "/usr/bin/wg-quick up /etc/wireguard/wg0.conf" ]

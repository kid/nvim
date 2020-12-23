FROM archlinux

RUN pacman -Sy
RUN pacman -Su base base-devel git sudo --noconfirm --needed

RUN useradd build -m
RUN echo "build ALL=NOPASSWD: ALL" >> /etc/sudoers

USER build
WORKDIR /home/build
RUN curl -SL https://aur.archlinux.org/cgit/aur.git/snapshot/yay-bin.tar.gz | \
    tar -xvz && \
    cd yay-bin && \
    makepkg -si --noconfirm && \
    rm -rf yay-bin

RUN yay -S neovim-nightly --noconfirm

COPY --chown=1000:1000 ./ ./.config/nvim/

CMD ["/bin/bash"]

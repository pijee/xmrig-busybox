# Create tempory container for compilation
FROM alpine:latest as builder
WORKDIR /build

# Prepare environnement
RUN apk upgrade -U && \
    apk add git make cmake libstdc++ gcc g++ automake libtool autoconf linux-headers && \
    git clone https://github.com/xmrig/xmrig && \
    sed -i 's/ = 1;/ = 0;/g' xmrig/src/donate.h

# Prepare deps
RUN cd xmrig/scripts && sh build.uv.sh && sh build.hwloc.sh && sh build.openssl.sh

# Compile
RUN mkdir xmrig/build && cd xmrig/build && \
    cmake .. -DXMRIG_DEPS=scripts/deps -DBUILD_STATIC=ON && \
    make -j $(nproc || sysctl -n hw.ncpu || sysctl -n hw.logicalcpu)

# Create final image
FROM busybox:latest
COPY --from=builder /build/xmrig/build/xmrig /bin/xmrig
ENTRYPOINT [ "/bin/xmrig" ]
CMD [ "--help" ]
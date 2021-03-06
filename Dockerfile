FROM crystallang/crystal:0.36.1-alpine as build
RUN mkdir /build
ADD . /build
WORKDIR /build
RUN shards --production install

# https://crystal-lang.org/reference/using_the_compiler/index.html
# Building fully statical linked executables is currently only supported on Alpine Linux.
RUN mkdir bin
RUN crystal build main.cr --verbose --release --static -o bin/web
# RUN shards --production build web

FROM alpine:latest
WORKDIR /app
COPY --from=build /build/bin/web .
EXPOSE 3000
ENV KEMAL_ENV=production

CMD ["/app/web"]


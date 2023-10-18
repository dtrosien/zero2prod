# This tells docker to use the Rust official image
FROM rust:1.73.0 as builder
# Set working directory
WORKDIR /app
# Install environment dependancies
RUN apt update && apt install lld clang -y
# Copy the files from local machine to the Docker image
COPY . .
ENV SQLX_OFFLINE true
# Build executable
RUN cargo build --release --bin zero2prod


# Copy bin to slim runtime environmet to shrink the image
FROM debian:bookworm-slim AS runtime
WORKDIR /app

# Install OpenSSL - it is dynamically linked by some dependencies
# Install ca-certificates - it is needed to verify TLS certificates
# when establishing HTTPS connections
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends openssl ca-certificates \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
COPY --from=builder /app/target/release/zero2prod zero2prod
COPY configuration configuration
ENV APP_ENVIRONMENT production
ENTRYPOINT ["./zero2prod"]
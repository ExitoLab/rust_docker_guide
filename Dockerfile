# Use the official Rust image as the build environment
FROM rust:1.64 as builder

# Set the working directory
WORKDIR /usr/src/my_rust_app

# Copy the Cargo.toml and Cargo.lock files
COPY Cargo.toml Cargo.lock ./

# Copy the source code
COPY src ./src

# Build the application in release mode
RUN cargo build --release

# Use a minimal base image to run the application
FROM debian:buster-slim

# Copy the build artifact from the builder stage
COPY --from=builder /usr/src/my_rust_app/target/release/my_rust_app /usr/local/bin/my_rust_app

# Expose the application port
EXPOSE 8080

# Run the application
CMD ["my_rust_app"]

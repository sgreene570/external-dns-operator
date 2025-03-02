# Build the manager binary
FROM golang:1.16 as builder

WORKDIR /workspace
COPY . .

# Build
RUN make build-operator

# Use distroless as minimal base image to package the manager binary
# Refer to https://github.com/GoogleContainerTools/distroless for more details
FROM gcr.io/distroless/static:nonroot
WORKDIR /
COPY --from=builder /workspace/bin/externaldns-operator .
USER 65532:65532

ENTRYPOINT ["/externaldns-operator"]

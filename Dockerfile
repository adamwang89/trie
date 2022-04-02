# Build Stage
 FROM aegooby/rust-fuzz:latest AS builder

 ## Add source code to the build stage.
 ADD . /repo
 WORKDIR /repo

 ## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
 RUN cd fuzz && ${HOME}/.cargo/bin/cargo fuzz build

 # Package Stage
 FROM ubuntu:20.04

 ## TODO: Change <Path in Builder Stage>
 COPY --from=builder /repo/fuzz/target/x86_64-unknown-linux-gnu/release/no_ext_insert_rem / 
 COPY --from=builder /repo/fuzz/target/x86_64-unknown-linux-gnu/release/no_ext_insert /
 COPY --from=builder /repo/fuzz/target/x86_64-unknown-linux-gnu/release/prefix_iter / 
 COPY --from=builder /repo/fuzz/target/x86_64-unknown-linux-gnu/release/seek_iter /
 COPY --from=builder /repo/fuzz/target/x86_64-unknown-linux-gnu/release/trie_codec_proof / 
 COPY --from=builder /repo/fuzz/target/x86_64-unknown-linux-gnu/release/trie_proof_invalid /
 COPY --from=builder /repo/fuzz/target/x86_64-unknown-linux-gnu/release/trie_root_fix_len / 
 COPY --from=builder /repo/fuzz/target/x86_64-unknown-linux-gnu/release/trie_root_news /
 COPY --from=builder /repo/fuzz/target/x86_64-unknown-linux-gnu/release/trie_root /
  
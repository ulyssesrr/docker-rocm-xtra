
# Intro
[llama.cpp](https://github.com/ggerganov/llama.cpp) + [ROCm Support](https://github.com/ggerganov/llama.cpp/pull/1087)

# Usage

## Create `drun` alias (if it doesn't exist yet)

```shell

alias  drun='sudo docker run -it --network=host --device=/dev/kfd --device=/dev/dri --ipc=host --shm-size 16G --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $HOME/dockerx:/dockerx -v $(pwd):/current'

```
  

## Example Usage

```shell

drun --pull=always --rm ulyssesrr/rocm-xtra-llamacpp:latest \
    -m /current/models/nous-hermes-llama2-13b.ggmlv3.q5_K_M.bin \
    -t 12 \
    -c 2048 \
    --mirostat 2 \
    --mirostat-lr 0.1 \
    --mirostat-ent 5.0 \
    --color \
    --interactive-first \
    --keep -1 \
    --in-suffix "### Response: " \
    --reverse-prompt "### Instruction:" \
    -p "### Instruction: " \
    --gpu-layers 24

```
Note: `/current` maps to the current directory in the host from where `drun` was invoked.
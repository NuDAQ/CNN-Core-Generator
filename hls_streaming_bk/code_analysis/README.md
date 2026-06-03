# code_analysis

Generated helper artifacts for navigating `hls_streaming`.

```text
tags           ctags symbol index
cscope.files   source list for cscope-style indexing
```

`ap_types` and `build` are intentionally excluded from the source list. The
current model path is in `firmware/cnn_core.cpp`, `firmware/parameters.h`, and
the active stream helpers under `firmware/nnet_utils`.

The local `cscope` binary generated `cscope.out`, but query mode reported:

```text
cannot read trailer offset
```

Use `rg` and `ctags` as reliable navigation tools unless cscope is regenerated
from a simpler path.

AI-agent workflow:

```text
1. Read ../AI_CONTEXT.md first.
2. Use this directory for symbol navigation and source lists.
3. Do targeted code reads before editing.
4. Regenerate indexes after meaningful code movement or added files.
5. Update ../AI_CONTEXT.md with durable new facts so future agents do not need
   to rediscover them.
```

Regenerate ctags:

```bash
ctags -R -f hls_streaming/code_analysis/tags hls_streaming/firmware hls_streaming/tb
```

Refresh source list:

```bash
find hls_streaming/firmware hls_streaming/tb \
  -path 'hls_streaming/firmware/ap_types' -prune -o \
  -path 'hls_streaming/build' -prune -o \
  -type f \( -name '*.h' -o -name '*.cpp' \) -print \
  > hls_streaming/code_analysis/cscope.files
```

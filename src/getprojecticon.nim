import os, strutils

const
  depth {.intdefine.} = 5
  nimIcon = "👑"
  rustIcon = "🦀"
  pythonIcon = "🐍"
  goIcon = "🐹"

var dir = getCurrentDir()

template isFile(pc: PathComponent): bool = pc == pcFile or pc == pcLinkToFile
template finish(s: string) = stdout.write s; quit 0

for _ in 1..depth:
  for k, f in walkDir dir:
    if k.isFile:
      let n = f.extractFilename
      if n.endsWith ".nimble":
        finish nimIcon
      case n:
      of "Cargo.toml":
        finish rustIcon
      of "setup.py", "requirements.txt":
        finish pythonIcon
      of "go.mod", "go.sum", "Gopkg.yml", "Gopkg.lock":
        finish goIcon
       else:
        discard
  if dir == "/":
    break
  else:
    dir = parentDir dir

stdout.write " "
quit 1

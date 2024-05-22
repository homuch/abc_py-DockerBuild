if (Test-Path -Path "./source") {
    Remove-Item -Path "./source" -Force -Recurse
}

New-Item -ItemType Directory -Path "./source" -Force

Invoke-WebRequest -Uri "https://github.com/pybind/pybind11/archive/refs/tags/v2.12.0.zip" -OutFile "./pybind11.zip"

Expand-Archive -Path "./pybind11.zip" -DestinationPath "./pybind11-tmp"
Move-Item -Path "./pybind11-tmp/pybind11*" -Destination "./source/pybind11"
Remove-Item -Path "./pybind11-tmp" -Force

Invoke-WebRequest -Uri "https://github.com/berkeley-abc/abc/archive/refs/heads/master.zip" -OutFile "./abc.zip"

Expand-Archive -Path "./abc.zip" -DestinationPath "./abc-tmp"
Move-Item -Path "./abc-tmp/abc*" -Destination "./source/abc"
Remove-Item -Path "./abc-tmp" -Force

Invoke-WebRequest -Uri "https://github.com/homuch/abc_py/archive/refs/heads/master.zip" -OutFile "./abc_py.zip"

Expand-Archive -Path "./abc_py.zip" -DestinationPath "./abc_py-tmp"
Move-Item -Path "./abc_py-tmp/abc_py*" -Destination "./source/abc_py"
Remove-Item -Path "./abc_py-tmp" -Force

Remove-Item -Path "./*.zip" -Force

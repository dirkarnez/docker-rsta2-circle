docker build -t rsta2-circle .
docker run --rm -it -v "%cd%/export:/home/ubuntu/circle/export" rsta2-circle
pause

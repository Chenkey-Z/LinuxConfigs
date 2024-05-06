import os
import filetype


class Video:
    def __init__(self, base_dir: str):
        self._base_dir = os.path.expanduser(base_dir)
        self._videos = []

    def setBaseDir(self, base_dir: str):
        self._base_dir = base_dir

    def getBaseDir(self) -> str:
        return self._base_dir

    def getVideos(self) -> list:
        return self._videos

    def _getVideoInDir(self) -> list:
        total_dirs = os.walk(self._base_dir)
        files_list = []
        result = []
        for root, dirs, files in total_dirs:
            for file in files:
                files_list.append(f"{root}/{file}")

        for file in files_list:
            kind = filetype.guess(file)
            if kind is None:
                continue

            if kind.mime.startswith("video/"):
                result.append(file)
        return result

    def search(self):
        self._videos = self._getVideoInDir()

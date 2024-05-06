import os
import cv2


class Catcher:
    def __init__(self, path: str):
        self.video = os.path.abspath(os.path.expanduser(path))
        self._cache_path = os.path.abspath(os.path.dirname(__file__) + "/../.cache")

    def capture(self):
        cap = cv2.VideoCapture(self.video)
        cap.set(cv2.CAP_PROP_POS_FRAMES, 100)
        status, frame = cap.read()

        if status is False:
            print("Error")
            return

        if os.path.exists(self._cache_path) is False:
            os.mkdir(self._cache_path)

        name = os.path.split(self.video)[1]
        cv2.imwrite(f"{self._cache_path}/{name}.jpg", frame)
        cv2.imshow("test", frame)
        cv2.waitKey(0)

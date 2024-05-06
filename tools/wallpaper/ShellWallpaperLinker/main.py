from core.video import Video
from core.linker import setSoftLink

if __name__ == "__main__":
    wallpapers = Video("/home/chenkeyz/.steam/steam/steamapps/workshop/content/431960")
    wallpapers.search()
    videos = wallpapers.getVideos()
    print("已找到视频并链接：")
    for video in videos:
        print(video)
    setSoftLink(videos, "/home/chenkeyz/视频/wallpapers/")

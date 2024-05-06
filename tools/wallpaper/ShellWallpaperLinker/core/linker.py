import os


def setSoftLink(videos: list, position: str):
    for video in videos:
        os.system(f'ln -srf "{video}" "{position}"')

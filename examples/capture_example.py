import cv2


def main():
    camera_index = 0
    capture = cv2.VideoCapture(camera_index)
    if not capture.isOpened():
        raise IOError("can't open capture!")

    while True:
        result, image = capture.read()
        if result is False:
            cv2.waitKey(0)
            break
        cv2.imshow("image", image)
        key = cv2.waitKey(1)
        if key == ord('q'):
            break
    cv2.destroyAllWindows()


if __name__ == '__main__':
    main()

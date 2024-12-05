import cv2
import sys

if len(sys.argv) != 2:
    print("missing arg")
    exit()
cam_i = sys.argv[1]

cap = cv2.VideoCapture(int(cam_i))

if not cap.isOpened():
    print("err")
    exit()

while True:
    ret, frame = cap.read()

    if not ret:
        print('frame')
        break

    cv2.imshow("cam", frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

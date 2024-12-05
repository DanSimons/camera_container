import cv2


cap1 = cv2.VideoCapture(0)
cap2 = cv2.VideoCapture(2)

if not cap1.isOpened():
    print("err open cap1")
    exit()

if not cap2.isOpened():
    print("err open cap2")
    exit()


while True:

    ret1, frame1 = cap1.read()
    if not ret1:
        print(f'ret1: {ret1}')
    else:
        cv2.imshow("cam1", frame1)

    ret2, frame2 = cap2.read()
    if not ret2:
        print(f'ret2: {ret2}')
    else:
        cv2.imshow("cam2", frame2)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

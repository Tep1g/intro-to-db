if __name__ == "__main__":
    usr_num = int(input("Please enter an integer: "))
    if usr_num < 0:
        raise ValueError("Invalid integer {}".format(usr_num))

    if usr_num == 0:
        answer = 1
    else:
        answer = usr_num
        for n in range(usr_num-1, 0, -1):
            answer *= n

    print("{}! = {}".format(usr_num, answer))
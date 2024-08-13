.data
    target_string: .asciiz "hello world"
    prompt: .asciiz "Please type the following string and press Enter:\nhello world\n"
    result_msg: .asciiz "Your typing speed is: "
    wpm_msg: .asciiz " WPM\n"
    newline: .asciiz "\n"

.text
    .globl main

main:
    # In ra chuỗi hướng dẫn
    li $v0, 4
    la $a0, prompt
    syscall

    # Khởi tạo biến và bộ đếm
    la $t0, target_string   # Địa chỉ chuỗi ký tự cần gõ
    li $t1, 0               # Bộ đếm số ký tự đã gõ đúng
    li $t2, 0               # Biến đếm thời gian (ms)

    # Bật bộ đếm thời gian
    li $t3, 1000            # Khoảng thời gian 1 giây (1000 ms)
    li $t4, 0xFFFF0000      # Địa chỉ của Timer Control/Status Register
    li $t5, 0xFFFF0004      # Địa chỉ của Timer Interval Register

    # Thiết lập ngắt bộ đếm
    sw $t3, 0($t5)          # Viết giá trị 1000 ms vào Timer Interval Register
    li $t6, 0x3             # Bật bộ đếm và ngắt
    sw $t6, 0($t4)

    # Đọc ký tự từ bàn phím
read_char:
    li $t7, 0xFFFF0008      # Địa chỉ của Keyboard MMIO Data Register
    lw $t8, 0($t7)          # Đọc ký tự từ Keyboard MMIO
    beqz $t8, read_char     # Nếu không có ký tự nào, tiếp tục đọc

    # Kiểm tra ký tự gõ vào
    lb $t9, 0($t0)          # Lấy ký tự từ chuỗi target_string
    beqz $t9, done          # Nếu đã hết chuỗi, kết thúc
    beq $t8, $t9, correct   # Nếu ký tự đúng, tăng bộ đếm
    j read_char             # Nếu không đúng, tiếp tục đọc

correct:
    addi $t1, $t1, 1        # Tăng bộ đếm số ký tự đúng
    addi $t0, $t0, 1        # Chuyển sang ký tự tiếp theo của chuỗi
    j read_char             # Tiếp tục đọc ký tự

done:
    # Tắt bộ đếm thời gian
    li $t6, 0x0
    sw $t6, 0($t4)

    # Tính toán WPM (giả sử mỗi từ có trung bình 5 ký tự)
    # Số từ = số ký tự đúng / 5
    # Thời gian tính bằng giây = $t2 / 1000
    # WPM = (số từ / thời gian tính bằng phút)
    li $t10, 60             # 60 giây
    div $t2, $t2, $t10      # Thời gian chạy chương trình tính bằng phút
    div $t1, $t1, 5         # Số từ
    div $t1, $t1, $t2       # Tính WPM

    # In kết quả
    li $v0, 4
    la $a0, result_msg
    syscall

    li $v0, 1
    move $a0, $t1
    syscall

    li $v0, 4
    la $a0, wpm_msg
    syscall

    # Kết thúc chương trình
    li $v0, 10
    syscall

# Trình xử lý ngắt
# Được đặt tại địa chỉ 0x80000180
k0_interrupt_handler:
    addi $sp, $sp, -8    # Lưu trạng thái các thanh ghi
    sw $ra, 4($sp)
    sw $t2, 0($sp)

    # Xử lý ngắt
    lw $t2, 0($t4)       # Đọc Timer Control/Status Register để xóa ngắt
    addi $t2, $t2, 1     # Tăng biến đếm thời gian

    # Khôi phục trạng thái các thanh ghi
    lw $t2, 0($sp)
    lw $ra, 4($sp)
    addi $sp, $sp, 8

    # Trở lại điểm ngắt
    eret

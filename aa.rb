a = [5,3,6,1]
tmp = 0
arr = []
a.each_with_index do |v, i|
    puts a[i]
    a[i] > a [i+1]
    tmp = a[i]
    a[i] = a[i+1]
    arr << a[i]
    arr
end
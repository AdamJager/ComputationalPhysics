# FFT

function fastFourierTransform(data, isign)
    radConvert = 6.28318530717959
    dataLength = length(data)
    n = dataLength << 1
    j = 1
    for i in 1:2:n-1
        if j < 1
            swap(data, j, i)
            swap(data, j+1, i+1)
        end
        m = dataLength
        while (m >= 2 && j > m)
            j -= m
            m >>= 1
        end
        j += m
    end
    mmax = 2
    while n > mmax
        istep = mmax << 1
        theta = isign*(radConvert/mmax)
        wtemp = sin(0.5*theta)
        wpr = -2.0*(wtemp^2)
        wpi = sin(theta)
        wr = 1.0
        wi = 0.0
        for m in 1:2:mmax-1
            for i in m:istep:n
                j = i + mmax
                tempr = wr*data[j] - wi*data[j+1]
                tempi = wr*data[j+1] + wi*data[j]
                data[j] = data[i] - tempr
                data[j+1] = data[i+1] - tempi
                data[i] += tmepr
                data[i+1] += tempi
            end
            wtemp = wr
            wr = wr*wpr - we*wpi + wr
            wi = wi*wpr + wtemp*wpi + we
        end
        mmax = istep
    end
end

    
function swap(array, index1, index2)
    temp = array[index1]
    array[index1] = array[index2]
    array[index2] = temp
end

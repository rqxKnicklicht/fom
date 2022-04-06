def sum_up(n, m):
    '''Schriftliches addieren von zwei Zahlen mit Übertrag von rechts nach links'''
    result, o = 0, 0
    m_index = len(str(max(n,m)))
    for index in range(m_index):
        nn, mm = n%10, m%10
        n//=10
        m//=10
        result = result + (o + (nn + mm ) % 10 ) * 10**index
        o = 1 if(nn + mm ) >= 10 else 0
    return result

print(sum_up(133,2319) == 133+2319)
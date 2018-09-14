!------------------------------------------------------------------------------!
!  Q version 5.7                                                               !
!  Code authors: Johan Aqvist, Martin Almlof, Martin Ander, Jens Carlson,      !
!  Isabella Feierberg, Peter Hanspers, Anders Kaplan, Karin Kolmodin,          !
!  Petra Wennerstrom, Kajsa Ljunjberg, John Marelius, Martin Nervall,          !
!  Johan Sund, Ake Sandgren, Alexandre Barrozo, Masoud Kazemi, Paul Bauer,     !
!  Miha Purg, Irek Szeler,  Mauricio Esguerra                                  !
!  latest update: August 29, 2017                                              !
!------------------------------------------------------------------------------!


module misc
!------------------------------------------------------------------------------!
!!  Copyright (c) 2017 Johan Aqvist, John Marelius, Shina Caroline Lynn Kamerlin
!!  and Paul Bauer
!!  misc.f90
!  by John Marelius & Johan Aqvist
!  miscellaneous utility functions
!------------------------------------------------------------------------------!

  use sizes

  implicit none

  ! version data
  character(*), private, parameter :: MODULE_VERSION = '5.7'
  character(*), private, parameter :: MODULE_DATE = '2015-02-22'

contains


subroutine centered_heading(msg, fill)
!------------------------------------------------------------------------------!
!!  subroutine: centered_heading
!!  creates a centered heading of a fixed size of 79 columns
!------------------------------------------------------------------------------!
  character(*) :: msg
  character    :: fill
  integer      :: n, i

  n = (78 - len(msg)) / 2
  write(*,'(80a)') (fill, i=1,n), ' ', msg, ' ', (fill, i=1,n-1)
end subroutine centered_heading


integer function freefile()
!------------------------------------------------------------------------------!
!!  function: freefile
!!
!------------------------------------------------------------------------------!
  integer                         :: u
  logical                         :: used

  do u = 20, 999
    inquire(unit=u, opened=used)
    if(.not. used)  then
      freefile = u
      return
    end if
  end do

  !if we got here then we've ran out of unit numbers
  write(*,20)
  stop 255

20 format('ERROR: Failed to find an unused unit number')

end function freefile


subroutine skip_comments(unit)
!------------------------------------------------------------------------------!
!!  subroutine: skip_comments
!!
!------------------------------------------------------------------------------!
  INTEGER unit

  CHARACTER(1000) c
  c = '*'

  DO while(c(1:1) =='*'.or.c(1:1) =='!'.or.c(1:1) =='#')
    READ(unit = unit, fmt = '(a)', end = 100, err = 100) c
  enddo
  !        go to beginning of record
  BACKSPACE(unit)
100 RETURN
end subroutine skip_comments



  subroutine getlin(intxt, outtxt)
    !arguments
    CHARACTER(*), intent(out)       ::      intxt
    character(*), intent(in), optional :: outtxt

    if(present(outtxt)) then
       write( * , '(a)', advance='no') outtxt
    end if
    READ( * , '(a)') intxt

  end subroutine getlin


  subroutine upcase(string)
    !arguments
    character(*), intent(inout)::   string

    integer                                         ::      i,c

    do i=len_trim(string), 1, -1
       c = ichar(string(i:i))
       if(c >=97 .and. c <= 122) c = iand(c, 223)
       string(i:i) = char(c)
    end do
  end subroutine upcase

subroutine locase(string)
    !arguments
    character(*), intent(inout)::   string

    integer                                         ::      i, c

    do i=len(string), 1, -1
       c = ior(ichar(string(i:i)), 32)
       string(i:i) = char(c)
    end do
end subroutine locase

character(len=3) function onoff(l)
    !arguments
    logical                                         ::      l
    if(l) then 
       onoff='on'
    else
       onoff='off'
    endif
end function onoff

integer function string_part(string, separator, start)
    !arguments
    character(*)                            ::      string, separator
    integer                                         ::      start
    !locals
    integer                                         ::      totlen
    totlen = len_trim(string)
    string_part = index(string(start:totlen), separator)
    if(string_part == 0) then 
       string_part = totlen
    else
       string_part = string_part - 2 + start
    end if
end function string_part

real(8) function rtime()
  integer :: timevals(8)
  call date_and_time(values=timevals)
  rtime = timevals(3)*24*3600+timevals(5)*3600+timevals(6)*60+timevals(7)+0.001*timevals(8)
end function rtime


end module misc


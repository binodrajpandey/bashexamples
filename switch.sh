animal=$1
case  $animal in
    cat)
        echo evil;;
    wolf|dog|human|mouse|dolphon|whale)
        echo mammal;;
    duck|goose|albatross)
        echo bird;;
    shark|trout|stingray)
        echo fish;;
    *)
        echo I have no idea what a $animal is;
esac

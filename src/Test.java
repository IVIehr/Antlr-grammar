import Math; // imports all from math
from Math import *; // imports all from math
from root.myMath import random; // imports random from root.myMath
from math import random,floor; // imports random and floor from math
from math import random =>rand;

class Point implements Movable with Plottable {
    private var px:int,py:int;

    Point(int px =0, int py =0) {
        this.px = px;
        this.py = py;
    }

    int moveHorizontal(int step) {
        px += step;
        while (step != 0) {
            print(step);
            step--;
        }
        return px;
    }
}

public class Test {
const myConst ="LoremIpsum";
    var myVar :Int =25,myStr :String;
    var myArray :new Array [Double](4);
const myInitiatedArray = Array(11,42,90.25,43);

    public static void main(int num1, int num2) {
    import javaFx;
        var point :new Point(1, 2);
        const origin:new Point();

        for (int myVar = 0; myVar < count && count > 5; myVar++) {
            sum += myVar;
            for (var obj in myList){
                newList.add(obj.name);
                if( obj != null){
                    print("hi");
                }
                else print("buy");
                break;
            }
        }
    }
}
class Test2{
    public void method(){

        try {
            res = num1 / num2;
        }
        on DivisionByZeroException catch (e) {
                print ("num 2 = 0");
        print (e);
}
catch (e) {
                print (e, "oops.");
}

        switch (name) {
            case "Jan":
                print("it is January");
                break;
            case "Feb":
            case "Dec":
                print("close enough");
                break;
            default:
                print("tryy again");
        }
    }
}



class Stack {
   -- Definition for an empty Stack

   terminate : Bool <- false;

   setTerminate(b : Bool) : Bool { terminate <- b };

   isTerminated() : Bool { terminate };

   isNil() : Bool { true };

   peek() : String { {abort(); "";} };

   tail() : Stack { {abort(); self;} };

   push(element : String): Stack {
      (new Cons).init(element, self)
   };
};

class Main inherits IO {
   
   myStack : Stack;

   main() : Object {
      {
      myStack <- new Stack;

      while (not myStack.isTerminated()) loop
         {
         	out_string(">");

         	(let strInput : String <- in_string() in 
         		if strInput = "e" then myStack <- eval(myStack) else
         		if strInput = "d" then print(myStack) else
         		if strInput = "x" then {
         			myStack.setTerminate(true);
         			} 
         		else
         		myStack <- myStack.push(strInput)
         		fi fi fi
         	);
         }
         pool;
      }
   };

   print(s : Stack) : IO {
      if s.isNil() then out_string("") else {
         out_string(s.peek());
         out_string("\n");
         print(s.tail());
      }
      fi
   };

   eval(s : Stack) : Stack {
      	if s.isNil() then s else
      	if s.peek() = "+" then add(s) else
      	if s.peek() = "s" then swap(s) else s
      	fi fi fi
    };

    swap(s : Stack) : Stack {
    	{
    		s <- s.tail();
    		let first : String <- s.peek(), second : String <- s.tail().peek() in {
    			s <- s.tail().tail();
    			s <- s.push(first);
    			s <- s.push(second);
    		};
    	}
    };

    add(s : Stack) : Stack {
    	{
    		s <- s.tail();
    		let first : Int <- (new A2I).a2i(s.peek()), second : Int <- (new A2I).a2i(s.tail().peek()) in {
    			s <- s.tail().tail();
    			first <- first + second;
    			s <- s.push((new A2I).i2a(first));
    		};
    	}
    };
};

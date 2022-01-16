import cpp

class NetworkByteSwap extends Expr {

    NetworkByteSwap() {
        exists(MacroInvocation m | m.getMacroName() in ["ntohs", "ntohl", "ntohll"] and 
        m.getExpr() = this)
    }

}


from NetworkByteSwap n
select n, "Network byte swap"
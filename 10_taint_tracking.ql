import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph


class NetworkByteSwap extends Expr {

    NetworkByteSwap() {
        exists(MacroInvocation m | m.getMacroName() in ["ntohs", "ntohl", "ntohll"] and 
        m.getExpr() = this)
    }

}

class Config extends TaintTracking::Configuration {
    Config() { this = "NetworkToMemFuncLength" }
  
    override predicate isSource(DataFlow::Node source) {
      source.asExpr() instanceof NetworkByteSwap
    }
    override predicate isSink(DataFlow::Node sink) {
      exists(FunctionCall c | c.getTarget().hasName("memcpy") and c.getArgument(2) = sink.asExpr())
    }
  }
  
  from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
  where cfg.hasFlowPath(source, sink)
  select sink, source, sink, "Network byte swap flows to memcpy"

//from NetworkByteSwap n
//select n, "Network byte swap"
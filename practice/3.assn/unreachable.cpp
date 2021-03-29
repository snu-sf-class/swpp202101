#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include<string>
using namespace llvm;

namespace {
class MyUnreachablePass : public PassInfoMixin<MyUnreachablePass> {
public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM) {
    outs() << "UNIMPLEMENTED\n";
    return PreservedAnalyses::all();
  }
};
}

extern "C" ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {
    LLVM_PLUGIN_API_VERSION, "MyUnreachablePass", "v0.1",
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, FunctionPassManager &FPM,
           ArrayRef<PassBuilder::PipelineElement>) {
          if (Name == "my-unreachable") {
            FPM.addPass(MyUnreachablePass());
            return true;
          }
          return false;
        }
      );
    }
  };
}

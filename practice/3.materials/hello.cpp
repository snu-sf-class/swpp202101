#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include<string>
using namespace llvm;

namespace {
class HelloPass : public PassInfoMixin<HelloPass> {
public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM) {
    StringRef funcName = F.getName();
    outs() << "Hello, " << funcName << "!\n";
    return PreservedAnalyses::all();
  }
};
}

extern "C" ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {
    LLVM_PLUGIN_API_VERSION, "HelloPass", "v0.1",
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, FunctionPassManager &FPM,
           ArrayRef<PassBuilder::PipelineElement>) {
          if (Name == "hello") {
            FPM.addPass(HelloPass());
            return true;
          }
          return false;
        }
      );
    }
  };
}
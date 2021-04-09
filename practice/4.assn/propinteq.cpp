#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;
using namespace std;

namespace {
class PropagateIntegerEquality : public PassInfoMixin<PropagateIntegerEquality> {
public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM) {
    return PreservedAnalyses::all();
  }
};
}

extern "C" ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {
    LLVM_PLUGIN_API_VERSION, "PropagateIntegerEquality", "v0.1",
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, FunctionPassManager &FPM,
           ArrayRef<PassBuilder::PipelineElement>) {
          if (Name == "prop-int-eq") {
            FPM.addPass(PropagateIntegerEquality());
            return true;
          }
          return false;
        }
      );
    }
  };
}

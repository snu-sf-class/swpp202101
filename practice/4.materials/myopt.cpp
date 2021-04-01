#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include<vector>

using namespace llvm;
using namespace std;

namespace {
class MyOptimizer : public PassInfoMixin<MyOptimizer> {
public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM) {
    vector<Instruction *> instsToRemove;
    for (auto &BB : F) {
      for (auto &I : BB) {
        switch (I.getOpcode()) {
        case Instruction::Add:
        case Instruction::Sub: {
          Value *V1 = I.getOperand(0);
          Value *V2 = I.getOperand(1);
          // I is 'add V1, V2' or 'sub V1, V2'
          // Are V1, V2 constants?
          auto *C1 = dyn_cast<ConstantInt>(V1);
          auto *C2 = dyn_cast<ConstantInt>(V2);
          if (C1 == nullptr || C2 == nullptr)
            // No, they aren't.
            break;

          uint64_t a = C1->getZExtValue();
          uint64_t b = C2->getZExtValue();
          uint64_t result = I.getOpcode() == Instruction::Add ? a + b : a - b;
          auto *CAdd = ConstantInt::get(C1->getType(), result, false);

          dbgs() << "MyDebug: Replacing '" << I << "' with " << *CAdd << "..\n";
          // Let's replace I's uses with CAdd.
          //
          //   x = add 1, 2
          //   use(x)
          // =>
          //   x = add 1, 2
          //   use(3)
          I.replaceAllUsesWith(CAdd);
          instsToRemove.push_back(&I);
          break;
        }
        default:
          // Unknown instruction!
          break;
        }
      }
    }
    for (auto *I : instsToRemove)
      I->eraseFromParent();

    return PreservedAnalyses::none();
  }
};
}

extern "C" ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {
    LLVM_PLUGIN_API_VERSION, "MyOptimizer", "v0.1",
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, FunctionPassManager &FPM,
           ArrayRef<PassBuilder::PipelineElement>) {
          if (Name == "my-opt") {
            FPM.addPass(MyOptimizer());
            return true;
          }
          return false;
        }
      );
    }
  };
}

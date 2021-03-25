#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include<string>
using namespace llvm;

namespace {
class DumpPass : public PassInfoMixin<DumpPass> {
public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM) {
    StringRef funcName = F.getName();
    outs() << "<<" << funcName << ">>\n";
    // To print whole function, try:
    // outs() << F << "\n";
    // If you want to get std::string from StringRef, try: funcName.str()

    for (auto I = F.begin(); I != F.end(); ++I) { // or, 'for (BasicBlock &BB : F) {'
      BasicBlock &BB = *I;
      outs() << "BasicBlock: " << BB.getName() << "\n";

      unsigned successorCnt = BB.getTerminator()->getNumSuccessors();
      outs() << "\tSuccessors: total " << successorCnt << " (";
      for (unsigned i = 0; i < successorCnt; ++i)
        outs() << (i == 0 ? "" : " ")
               << BB.getTerminator()->getSuccessor(i)->getName();
      outs() << ")\n";

      for (Instruction &I : BB)
        outs() << "\t" << I << "\n";
    }
    return PreservedAnalyses::all();
  }
};
}

extern "C" ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {
    LLVM_PLUGIN_API_VERSION, "DumpPass", "v0.1",
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, FunctionPassManager &FPM,
           ArrayRef<PassBuilder::PipelineElement>) {
          if (Name == "dump") {
            FPM.addPass(DumpPass());
            return true;
          }
          return false;
        }
      );
    }
  };
}
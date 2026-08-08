"use client";

import { useRouter } from "next/navigation";
import { ChevronLeft, ChevronRight } from "lucide-react";

/**
 * Back / Forward navigation pills mounted at the leftmost end of the
 * header, just before the brand cluster. Browser history doesn't expose
 * a reliable "can go back/forward" signal across browsers, so we don't
 * try to gray-out — buttons always feel clickable; if there's nothing
 * to navigate to, router.back/forward simply no-ops.
 */
export function NavHistoryButtons() {
  const router = useRouter();

  // Same quiet rounded-square chrome as the search + sidebar-collapse icons
  // sitting beside them (rounded-xl · hairline border · soft fill), so the
  // whole top control row reads as one set of neutral icon buttons rather than
  // two red pills followed by two grey squares.
  const iconButton =
    "inline-grid place-items-center h-10 w-10 rounded-xl border border-hairline bg-surface-soft text-ink-subtle transition-colors hover:bg-surface-card hover:border-hairline-strong hover:text-ink-strong focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-altus-red/30 max-md:h-9 max-md:w-9";

  return (
    <div className="flex items-center gap-1 max-xl:hidden shrink-0">
      <button
        type="button"
        aria-label="Back"
        title="Back"
        onClick={() => router.back()}
        className={iconButton}
      >
        <ChevronLeft size={18} strokeWidth={2.3} />
      </button>
      <button
        type="button"
        aria-label="Forward"
        title="Forward"
        onClick={() => router.forward()}
        className={iconButton}
      >
        <ChevronRight size={18} strokeWidth={2.3} />
      </button>
      <span
        aria-hidden
        className="ml-2 mr-1 inline-block"
        style={{
          width: 1,
          height: 24,
          background: "var(--color-hairline)",
        }}
      />
    </div>
  );
}

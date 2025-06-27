import { useState, useEffect } from 'react';

interface ScreenSize {
    width: number;
    height: number;
}

const getInitialScreenSize = (): ScreenSize => {
    if (typeof window === 'undefined') {
        return { width: 1024, height: 768 };
    }
    return {
        width: window.innerWidth,
        height: window.innerHeight
    };
};

export const useScreenSize = (): ScreenSize => {
    const [screenSize, setScreenSize] = useState<ScreenSize>(getInitialScreenSize);

    useEffect(() => {
        const handleResize = () => {
            const width = window.innerWidth;
            const height = window.innerHeight;

            setScreenSize({
                width,
                height
            });
        };

        // Set initial size on mount (handles SSR hydration)
        handleResize();

        // Add event listener
        window.addEventListener('resize', handleResize);

        // Cleanup
        return () => window.removeEventListener('resize', handleResize);
    }, []);

    return screenSize;
};
